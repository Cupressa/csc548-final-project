# folderInventoryAssist.py
# Jonah Lum
# 8/5/24

# At some point, implement a sorting algorithm for setlist (ignores spaces and punctuation, numbers first)
# To use sorting algorithm, change folder contents from list to dictionary  

from Levenshtein import distance
import datetime

class Owner:

    def __init__(self, name, folderName, paymentType, depositDate = datetime.datetime.now().strftime("%m/%d/%Y"), returnDate = "", lentStatus="LENT"):
        self.name = name
        self.folderName = folderName
        self.depositDate = depositDate
        self.paymentType = paymentType
        self.returnDate = returnDate
        self.lentStatus = lentStatus

    def setReturnDate(self, returnDate):
        self.returnDate = returnDate

    def setLentStatus(self, lentStatus):
        self.lentStatus = lentStatus

    def setPaymentType(self, paymentType):
        self.paymentType = paymentType

    def getName(self):
        return self.name

    def __str__(self):
        return self.name + "," + self.folderName + "," + self.depositDate + "," + self.paymentType + "," + self.returnDate + "," + self.lentStatus + "\n"

    def summary(self):
        return "{0:^30}{1:^10}{2:^14}{3:^14}{4:^13}{5:^8}".format(self.name, self.folderName, self.depositDate, self.paymentType, self.returnDate, self.lentStatus)

class Folder:

    def __init__(self, name, contents, visible):
        self.name = name.upper()
        self.contents = contents
        self.visible = visible
        self.owner = None

    def getContents(self):
        return self.contents

    def setContents(self, contents):
        self.contents = contents

    def getName(self):
        return self.name

    def getVisible(self):
        return self.visible

    def setVisible(self, visible):
        self.visible = visible

    def getOwner(self):
        return self.owner

    def setOwner(self, owner):
        self.owner = owner

    def printContents(self, songTitles):
        print("Folder:", self.name)
        print("{0:^30}{1:^20}{2:^20}".format("Song Title", "In Folder", "Not In Folder"))
        for i in range(len(self.contents)):
            if(self.contents[i] == '0'):
                print("{0:^30}{1:^20}{2:^20}".format(songTitles[i], "", "X"))
            else:
                print("{0:^30}{1:^20}{2:^20}".format(songTitles[i], "X", ""))

class InventorySession:

    def __init__(self):
        self.inventoryFileName = "folderInventory.csv"
        self.depositFileName = "folderDeposits.csv"
        self.folderDict, self.songTitles = self.createFolderDict()
        self.addOwners()
        outFile = open(self.getBackupFile(self.inventoryFileName), 'w', encoding="UTF-8-sig")
        outFile.writelines(self.compileInventorySave())
        outFile.close()
        outFile = open(self.getBackupFile(self.depositFileName), 'w', encoding="UTF-8-sig")
        outFile.writelines(self.compileDepositSave())
        outFile.close()

    def interface(self, command):
        match(command):
            case "h":
                print("""Commands:
    >>> afo - assign folder owner
    >>> anf - add new folder
    >>> ang - add new group
    >>> ans - add new song
    >>> cfc - change folder contents (all songs)
    >>> cfl - change folder lending status (LENT or RETURNED)
    >>> cfv - change folder visibility
    >>> cop - change owner payment
    >>> csa - change song status for all visible folders (missing or present)
    >>> css - change song status for a singular folder (missing or present)
    >>> h   - view help screen
    >>> psm - creates a summary of missing songs grouped by song, then by folder grouping
    >>> rfo - remove folder owner
    >>> rst - resets data to initial state when opening terminal
    >>> s   - save current changes to file
    >>> sum X summarize folder inventory (not implemented)
    >>> vcf - view completed folders
    >>> vfc - view contents of a specific folder
    >>> vif - view invisible folders
    >>> vlf - view all lent folders
    >>> vmf - view a list of missing songs for folders in a specific group 
    >>> vms - view a list of all folders that are missing songs
    >>> q   - quit session (alternatively, press CTRL + C)""")

            case "test":
                for section in self.folderDict.values():
                    for folder in section:
                        if "0" not in folder.getContents():
                            print(folder.getName())

            case "afo":
                folderName = input("Enter folder name: ").upper().strip()
                folder = self.accessFolder(folderName)
                if(folder == None):
                    print("Invalid folder name")
                    return 1
                if(folder.getVisible()):
                    if('0' in folder.getContents()):
                        print("Folder not available for use")
                        if not(self.override()):
                            return 1
                    if((folder.getOwner() != None) and (input("{0} is already assigned to {1}, would you like to change the owner? (y/n): ".format(folder.getName(), folder.getOwner().getName()))[0].lower() != 'y')):
                        return 1
                    name = input("Enter name: ").lower().strip()
                    paymentType = "none" if(input("Was the deposit paid? (y/n): ")[0].lower() == 'n') else ("cash" if(input("Was the deposit paid via cash or venmo? (c/v): ")[0].lower() == 'c') else "venmo")
                    folder.setOwner(Owner(name, folder.getName(), paymentType))
                else:
                    print("Folder is not available for use")
                    return 1
                
            case "ans":
                self.songTitles.append(input("Enter new song title: ").upper().strip())
                for group in self.folderDict.values():
                    for folder in group:
                        contents = folder.getContents()
                        contents.append('0')
                        folder.setContents(contents)
                
            case "anf":
                folderName = input("Enter folder name: ").upper().strip()
                try:
                    for folder in self.folderDict[folderName[0:2]]:
                        if(folderName == folder.getName()):
                            print("Folder already exists")
                            return 1
                except:
                    print("Invalid folder name")
                    return 1
                self.folderDict[folderName[0:2]].append(Folder(folderName, ["0"]*len(self.songTitles), False))

            case "ang":
                groupName = input("Enter folder group name: ").upper().strip()
                if(len(groupName) != 2):
                    print("Invalid folder group name")
                    return 1
                if not(groupName[0].isalpha() and groupName[1].isnumeric()):
                    print("Invalid folder group name")
                    return 1
                self.folderDict[groupName] = []

            case "cfc":
                # Autosaves and sets folder as visible by default
                folderName = input("Enter folder name: ").upper().strip()
                folder = self.accessFolder(folderName)
                if(folder == None):
                    print("Invalid folder name")
                    return 1
                folder.setVisible(True)
                newContents = []
                for song in self.songTitles:
                    # Standard input mode
                    # newContents.append('1' if (input("Is {0} in {1}? (y/n): ".format(song, folder.getName())).lower()[0] == 'y') else '0')
                    # Lazy input mode
                    newContents.append('1' if (input("Is {0} in {1}? (y/n): ".format(song, folder.getName())).lower() != 'n') else '0')
                folder.setContents(newContents)
                # Autosave after every cfc for now
                outFile = open("folderInventory.csv", 'w', encoding="UTF-8-sig")
                outFile.writelines(self.compileInventorySave())
                outFile.close()

            case "cfl":
                folderName = input("Enter folder name: ").upper().strip()
                folder = self.accessFolder(folderName)
                if(folder == None):
                    print("Invalid folder name")
                    return 1
                owner = folder.getOwner()
                if(owner == None):
                    print('Folder is not assigned an owner, assign owner using "afo" command')
                    return 1
                if(input("Is " + folder.getName() + " lent or returned? (l/r): ")[0].lower() == 'l'):
                    owner.setLentStatus("LENT")
                    owner.setReturnDate("")
                else:
                    owner.setLentStatus("RETURNED")
                    owner.setReturnDate(datetime.datetime.now().strftime("%m/%d/%Y"))

            case "cfv":
                folderName = input("Enter folder name: ").upper().strip()
                folder = self.accessFolder(folderName)
                if(folder == None):
                    print("Invalid folder name")
                    return 1
                folder.setVisible(input("Mark " + folder.getName() + " as visible or invisible? (v/i): ").lower()[0] == 'v')

            case "cop":
                folderName = input("Enter folder name: ").upper().strip()
                folder = self.accessFolder(folderName)
                if(folder == None):
                    print("Invalid folder name")
                    return 1
                owner = folder.getOwner()
                if(owner == None):
                    print('Folder is not assigned an owner, assign owner using "afo" command')
                    return 1
                paymentType = input("Set payment type: ").lower()
                pTypes = ["none", "venmo", "cash"]
                pDist = []
                for p in pTypes:
                    pDist.append(distance(p, paymentType))
                owner.setPaymentType(pTypes[pDist.index(min(pDist))])

            case "csa":
                songIndex, songDistance = self.songIndex(input("Enter song name: ").upper().strip())
                while(True):
                    if(songDistance == 0):
                        break
                    if(input("Did you mean {0}? (y/n): ".format(self.songTitles[songIndex])).lower()[0] == 'y'):
                        break
                    else:
                        songIndex, songDistance = self.songIndex(input("Enter song name: ").upper().strip())
                songStatus = '1' if (input("Is " + self.songTitles[songIndex] + " being added or removed? (a/r): ").lower()[0] == 'a') else '0'
                for group in self.folderDict.values():
                    for folder in group:
                        if(folder.getVisible()):
                            contents = folder.getContents()
                            contents[songIndex] = songStatus
                            folder.setContents(contents)

            case "css":
                folderName = input("Enter folder name: ").upper().strip()
                folder = self.accessFolder(folderName)
                if(folder == None):
                    print("Invalid folder name")
                    return 1
                songIndex, songDistance = self.songIndex(input("Enter song name: ").upper().strip())
                while(True):
                    if(songDistance == 0):
                        break
                    if(input("Did you mean {0}? (y/n): ".format(self.songTitles[songIndex])).lower()[0] == 'y'):
                        break
                    else:
                        songIndex, songDistance = self.songIndex(input("Enter song name: ").upper().strip())
                newContents = folder.getContents()
                newContents[songIndex] = '1' if (input("Is {0} in {1}? (y/n): ".format(self.songTitles[songIndex], folder.getName())).lower()[0] == 'y') else '0'
                folder.setContents(newContents)

            case "psm":
                missingDict = {}
                for section in self.folderDict.values():
                    for folder in section:
                        if(folder.getVisible()):
                            contents = folder.getContents()
                            for i in range(len(contents)):
                                if(contents[i] == "0"):
                                    if(not(self.songTitles[i] in missingDict)):
                                        missingDict[self.songTitles[i]] = {}
                                    if(folder.getName()[:2] in missingDict[self.songTitles[i]]):
                                        missingDict[self.songTitles[i]][folder.getName()[:2]] += 1
                                    else:
                                        missingDict[self.songTitles[i]][folder.getName()[:2]] = 1
                for song in sorted(missingDict):
                    print(song)
                    for group in missingDict[song]:
                        print("{0}: {1}".format(group, missingDict[song][group]))

            case "rfo":
                folderName = input("Enter folder name: ").upper().strip()
                folder = self.accessFolder(folderName)
                if(folder == None):
                    print("Invalid folder name")
                    return 1
                folder.setOwner(None)

            case "rst":
                if(input("Would you like to reset all changes made in this current session? (y/n): ")[0].lower() == 'y'):
                    if(input("Are you sure? Enter YES in all capitals to confirm this choice (all current changes + saves will be lost): ") == "YES"):
                        return self.resetToBackup()

            case "s":
                self.writeSave()

            case "vcf":
                for section in self.folderDict.values():
                    for folder in section:
                        if('0' not in folder.getContents()):
                            print(folder.getName())

            case "vfc":
                folderName = input("Enter folder name: ").upper().strip()
                try:
                    self.accessFolder(folderName).printContents(self.songTitles)
                except:
                    print("Invalid folder name")

            case "vif":
                for section in self.folderDict.values():
                    for folder in section:
                        if(not(folder.getVisible())):
                            print(folder.getName())

            case "vlf":
                print("{0:^30}{1:^10}{2:^14}{3:^14}{4:^13}{5:^8}".format("Name", "Folder #", "Deposit Date", "Payment Type", "Return Date", "Status"))
                for section in self.folderDict.values():
                    for folder in section:
                        owner = folder.getOwner()
                        if(owner != None):
                            print(owner.summary())

            case "vms":
                missingDict = {}
                for section in self.folderDict.values():
                    for folder in section:
                        if(folder.getVisible()):
                            contents = folder.getContents()
                            for i in range(len(contents)):
                                if(contents[i] == "0"):
                                    if(self.songTitles[i] in missingDict):
                                        missingDict[self.songTitles[i]] += folder.getName() + ", "
                                    else:
                                        missingDict[self.songTitles[i]] = folder.getName() + ", "
                for song in sorted(missingDict):
                    print("{0:>30}: {1}".format(song, missingDict[song][:-2]))

            case "vmf":
                tempString = "Groups: "
                for group in self.folderDict:
                    tempString += group + ", "
                group = input(tempString[:-2] + "\nWhich group would you like to search by? ").strip().upper()
                if(group not in self.folderDict):
                    print("Invalid folder group")
                    return 1
                missingDict = {}
                for folder in self.folderDict[group]:
                    if(folder.getVisible()):
                        contents = folder.getContents()
                        for i in range(len(contents)):
                            if(contents[i] == '0'):
                                if(self.songTitles[i] in missingDict):
                                    missingDict[self.songTitles[i]] += folder.getName() + ", "
                                else:
                                    missingDict[self.songTitles[i]] = folder.getName() + ", "
                for song in missingDict:
                    print("{0:>30}: {1}".format(song, missingDict[song][:-2]))

            case "q":
                return 0

            case _:
                print("Input not recognized (press h for help)")

        return 1

    def createFolderDict(self):
        inFile = open(self.inventoryFileName, 'r', encoding="UTF-8-sig")
        songTitles = inFile.readline().replace("\n", "").split(',')[1:-1]
        folderDict = {}
        for line in inFile:
            folderName = line.split(',')[0]
            contents = line.replace("\n", "").split(',')[1:-1]
            visible = line.replace("\n", "").split(',')[-1] == '1'
            if(folderName[0:2] not in folderDict):
                folderDict[folderName[0:2]] = [Folder(folderName, contents, visible)]
            else:
                folderDict[folderName[0:2]] += [Folder(folderName, contents, visible)]
        inFile.close()
        return folderDict, songTitles

    def addOwners(self):
        inFile = open(self.depositFileName, 'r', encoding="UTF-8-sig")
        inFile.readline()
        for line in inFile:
            processedLine = line.replace("\n", "").split(',')
            if(len(processedLine[0]) != 0):
                self.accessFolder(processedLine[1]).setOwner(Owner(processedLine[0], processedLine[1], processedLine[3], processedLine[2], processedLine[4], processedLine[5]))

    def accessFolder(self, folderName):
        if(len(folderName) == 0):
            return None
        if(folderName[0:2] not in self.folderDict):
            return None
        for folder in self.folderDict[folderName[0:2]]:
            if(folder.getName() == folderName):
                return folder
        return None

    def songIndex(self, songTitle):
        minLev = distance(songTitle, self.songTitles[0])
        closest = self.songTitles[0]
        for song in self.songTitles:
            tempLev = distance(songTitle, song)
            if(tempLev < minLev):
                minLev = tempLev
                closest = song
        return self.songTitles.index(closest), minLev

    def musicSort(self):
        tempList = []
        tempSong = ""
        for song in self.songTitles:
            for character in [" ", "THE", ",", "'", "-"]:
                tempSong = song.replace(character, "")
            tempList.append(tempSong)
        tempList.sort()
        print(tempList)

    def compileInventorySave(self):
        saveList = []
        tempLine = "Folder"
        for song in self.songTitles:
            tempLine += "," + song
        saveList.append(tempLine + ",VISIBILE\n")
        for section in self.folderDict.values():
            for folder in section:
                tempLine = folder.getName()
                for mark in folder.getContents():
                    tempLine += "," + mark
                tempLine += ",1" if (folder.getVisible()) else ",0"
                saveList.append(tempLine + "\n")
        return saveList

    def compileDepositSave(self):
        saveList = ["Name,Folder #,Deposit Date,Form of Payment,Return Date,Folder Status\n"]
        for section in self.folderDict.values():
            for folder in section:
                owner = folder.getOwner()
                if(owner == None):
                    saveList.append("," + folder.getName() + ",,,,RETURNED\n")
                else:
                    saveList.append(str(owner))
        return saveList

    def writeSave(self):
        outFile = open(self.inventoryFileName, 'w', encoding="UTF-8-sig")
        outFile.writelines(self.compileInventorySave())
        outFile.close()
        outFile = open(self.depositFileName, 'w', encoding="UTF-8-sig")
        outFile.writelines(self.compileDepositSave())
        outFile.close()

    def resetToBackup(self):
        self.inventoryFileName = self.getBackupFile(self.inventoryFileName)
        self.depositFileName = self.getBackupFile(self.depositFileName)
        self.folderDict, self.songTitles = self.createFolderDict()
        self.addOwners()
        self.inventoryFileName = self.inventoryFileName.replace("BACKUP.csv", ".csv")
        self.depositFileName = self.depositFileName.replace("BACKUP.csv", ".csv")
        self.writeSave()
        return 0

    def getBackupFile(self, fileName):
        return fileName.replace(".csv", "BACKUP.csv")

    def override(self):
        return (input("Override command? (y/n): ")[0].lower() == 'y') and (input("Confirm override - type YES: ") == "YES")

# to do later, summary method
    def __str__(self):
        return None

def main():
    terminal = InventorySession()
    while(True):
        try:
            if(terminal.interface(input("Enter command: ").lower().strip()) == 0):
                break
        except Exception as e:
            print(e)
    
    

if __name__=="__main__":
    main()
