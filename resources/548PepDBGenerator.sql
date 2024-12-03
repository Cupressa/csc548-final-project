CREATE DATABASE IF NOT EXISTS CSC548Band DEFAULT CHARSET=utf8mb4 COLLATE utf8mb4_unicode_ci;
USE csc548band;

CREATE USER pep_user@localhost IDENTIFIED BY "userProfile";
GRANT INSERT, SELECT, UPDATE, DELETE 
ON csc548band.*
TO pep_user@localhost;
SHOW GRANTS FOR pep_user@localhost;

DROP TABLE IF EXISTS requests;
CREATE TABLE requests (
	requestId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    netId INT NOT NULL,
    request_timestamp DATETIME,
    complete BOOL
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE utf8mb4_unicode_ci;
/*
INSERT requests VALUES (DEFAULT, 1, NOW(), FALSE);
INSERT folder_requests VALUES((SELECT MAX(requestId) FROM requests), 2);
INSERT song_requests VALUES((SELECT MAX(requestId) FROM requests), "White And Blue");
SELECT * FROM requests;
SELECT r.requestId, netId, request_timestamp, complete, section, song_title FROM requests r LEFT JOIN folder_requests f ON r.requestId = f.requestId LEFT JOIN song_requests s ON s.requestId = r.requestId WHERE complete=0;
*/
DROP TABLE IF EXISTS song_requests;
CREATE TABLE song_requests (
	requestId INT NOT NULL PRIMARY KEY,
    song_title VARCHAR(255) NOT NULL
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE utf8mb4_unicode_ci;

DROP TABLE IF EXISTS folder_requests;
CREATE TABLE folder_requests (
	requestId INT NOT NULL PRIMARY KEY,
    section INT NOT NULL
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE utf8mb4_unicode_ci;

DROP TABLE IF EXISTS members;
CREATE TABLE members (
	netId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    grade VARCHAR(255),
    section INT,
    attendance_score INT
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE utf8mb4_unicode_ci;

-- INSERT VALUES FOR MEMBERS
INSERT INTO members(grade, section, attendance_score) VALUES (2025, 1, 14), (2026, 3, 14), (2027, 2, 2), (2025, 4, 0),
	(2025, 3, 15), (2027, 6, 6), (2027, 5, 4), (2025, 1, 4), (2025, 3, 22), (2028, 2, 21);
INSERT INTO members(grade, section, attendance_score) VALUES (2027, 2, 4), (2026, 1, 10), (2027, 5, 5), (2028, 1, 10),
	(2027, 3, 13), (2025, 4, 16), (2026, 6, 19), (2027, 1, 13), (2027, 4, 15), (2025, 4, 20);
INSERT INTO members(grade, section, attendance_score) VALUES (2026, 2, 9), (2023, 1, 1), (2028, 3, 0), (2027, 5, 6),
	(2028, 4, 5), (2028, 2, 16), (2028, 3, 18), (2026, 6, 17), (2025, 4, 2), (2028, 1, 2);
INSERT INTO members(grade, section, attendance_score) VALUES (2027, 2, 0), (2026, 3, 14), (2027, 5, 12), (2025, 4, 0),
	(2025, 2, 1), (2027, 6, 0), (2028, 2, 0), (2025, 2, 7), (2028, 2, 0), (2027, 1, 1);

DROP TABLE IF EXISTS instruments;
CREATE TABLE instruments (
	instrumentId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    instrument_type TEXT,
    `condition` TEXT,
    netId INT NOT NULL,
    CONSTRAINT instruments_ibfk_1 FOREIGN KEY (netId) REFERENCES members (netid)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE utf8mb4_unicode_ci;

-- INSERT VALUES FOR INSTRUMENTS
INSERT INTO instruments(instrument_type, `condition`, netId) VALUES ("Mellophone", "good", 1), ("Trombone", "very good", 2),
	("Flute", "like new", 3), ("Alto Saxophone", "good", 4), ("Clarinet", "needs work", 5), ("Clarinet", "very good", 6),
    ("Sousaphone", "very good", 7), ("Trumpet", "good", 8), ("Alto saxophone", "needs work", 11), ("Piccolo", "good", 12);
INSERT INTO instruments(instrument_type, `condition`, netId) VALUES ("Trumpet", "like new", 9), ("Trombone", "needs work", 10),
	("Sousaphone", "good", 13), ("Flute", "like new", 14), ("Trombone", "needs work", 15), ("Mellophone", "like new", 16),
	("Tenor Saxophone", "good", 17), ("Clarinet", "good", 18), ("Clarinet", "very good", 19), ("Trumpet", "like new", 20);
INSERT INTO instruments(instrument_type, `condition`, netId) VALUES ("Mellophone", "like new", 21), ("Trombone", "needs work", 22),
	("Baritone Saxophone", "good", 23), ("Sousaphone", "good", 24), ("Trombone", "very good", 25), ("Sousaphone", "good", 26), 
    ("Trombone", "like new", 27), ("Baritone", "good", 28), ("Mellophone", "like new", 29), ("Alto Saxophone", "good", 30);
INSERT INTO instruments(instrument_type, `condition`, netId) VALUES ("Trumpet", "needs work", 31), ("Clarinet", "good", 32), 
	("Sousaphone", "very good", 33), ("Trombone", "needs work", 34), ("Baritone Saxophone", "very good", 35), ("Trumpet", "like new", 36),
    ("Mellophone", "good", 37), ("Tenor Saxophone", "very good", 38), ("Clarinet", "good", 39), ("Baritone", "good", 40);

DROP TABLE IF EXISTS folder;
CREATE TABLE folder (
	folderId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    section INT,
    loan_date DATETIME,
    payment_type VARCHAR(255),
    return_date DATETIME,
    netId INT NOT NULL,
    CONSTRAINT folder_ibfk_1 FOREIGN KEY (netId) REFERENCES members (netId)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE utf8mb4_unicode_ci;

-- INSERT VALUES FOR FOLDER
INSERT INTO folder VALUES (1001, 1, "2024-09-29", "Venmo", "2025-04-22", 1), (1002, 3, "2024-10-07", "cash", "2025-04-20", 2), (1003, 2, "2024-08-14", "cash", "2025-05-10", 3), 
	(1004, 4, "2024-08-10", "Venmo", "2025-04-29", 4), (1005, 3, "2024-09-13", "Venmo", "2025-05-09", 5), (1006, 6, "2024-09-08", "Venmo", "2025-05-18", 6), 
    (1007, 5, "2024-09-16", "cash", "2025-04-04", 7), (1008, 1, "2024-09-11", "Venmo", "2025-03-25", 8), (1009, 3, "2024-08-27", "Venmo", "2025-05-08", 9), 
    (1010, 2, "2024-08-15", "cash", "2025-03-27", 10);
INSERT INTO folder VALUES (1011, 2, "2024-09-30", "cash", "2025-05-20", 11), (1012, 1, "2024-09-10", "Venmo", "2025-05-02", 12), (1013, 5, "2024-10-02", "cash", "2025-05-03", 13),
	(1014, 1, "2024-08-14", "Venmo", "2025-05-23", 14), (1015, 3, "2024-08-22", "Venmo", "2025-04-25", 15), (1016, 4, "2024-08-14", "cash", "2025-04-28", 16), 
    (1017, 6, "2024-09-11", "Venmo", "2025-05-17", 17), (1018, 1, "2024-10-08", "cash", "2025-04-06", 18), (1019, 4, "2024-08-16", "cash", "2025-04-11", 19), 
    (1020, 4, "2024-09-02", "Venmo", "2025-03-27", 20);
INSERT INTO folder VALUES (1021, 2, "2024-08-25", "Venmo", "2025-04-05", 21), (1022, 1, "2024-08-23", "Venmo", "2025-03-28", 22), (1023, 3, "2024-10-04", "Venmo", "2025-05-21", 23),
	(1024, 5, "2024-08-20", "cash", "2025-04-17", 24), (1025, 4, "2024-08-13", "cash", "2025-04-17", 25), (1026, 2, "2024-09-27", "Venmo", "2025-05-10", 26), 
    (1027, 3, "2024-10-05", "cash", "2025-03-29", 27), (1028, 6, "2024-09-27", "Venmo", "2025-04-24", 28), (1029, 4, "2024-09-03", "cash", "2025-04-08", 29),
    (1030, 1, "2024-08-24", "cash", "2025-05-09", 30);
INSERT INTO folder VALUES (1031, 2, "2024-08-20", "Venmo", "2025-04-26", 31), (1032, 3, "2024-09-06", "Venmo", "2025-05-08", 32), (1033, 5, "2024-10-03", "cash", "2025-04-24", 33),
	(1034, 4, "2024-10-02", "Venmo", "2025-04-20", 34), (1035, 2, "2024-08-30", "Venmo", "2025-05-05", 35), (1036, 6, "2024-09-26", "Venmo", "2025-05-21", 36), 
    (1037, 2, "2024-08-19", "cash", "2025-05-14", 37), (1038, 2, "2024-08-18", "cash", "2025-03-30", 38), (1039, 2, "2024-09-12", "Venmo", "2025-04-12", 39),
    (1040, 1, "2024-08-28", "cash", "2025-05-19", 40);


DROP TABLE IF EXISTS song;
CREATE TABLE song (
	song_title VARCHAR(255) NOT NULL PRIMARY KEY,
    practice_score int,
    in_setlist BOOL
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE utf8mb4_unicode_ci;

-- INSERT VALUES FOR SONG
INSERT INTO song VALUES ("25 or 6 to 4", 3, 0), ("867-5309/Jenny", 3, 0), ("All the Small Things", 1, 1), ("Bad Romance", 2, 1), ("Blinding Lights", 5, 0), 
	("Build me up Buttercup", 3, 0), ("Carry on Wayward Son", 3, 0), ("Confident", 1, 0), ("Crazy Train", 1, 1), ("Dancing Queen", 2, 1);
INSERT INTO song VALUES ("Don’t Stop Believin", 1, 1), ("Dynamite", 1, 0), ("Every time we touch", 1, 1), ("Fat Bottomed Girls", 5, 0), ("Final Countdown", 5, 1), 
	("Funky Town", 2, 0), ("Good 4 U", 5, 0), ("Handclap", 1, 1), ("Havana", 1, 0), ("Hey! Baby", 2, 1), ("Hey Song", 5, 1);
INSERT INTO song VALUES ("High Hopes", 2, 0), ("High School Never Ends", 3, 1), ("Holiday", 3, 1), ("Hooked on a Feeling", 5, 0), ("How Far We’ve Come", 5, 1),
	("I Knew You Were Trouble", 3, 0), ("I Want You Back", 5, 0), ("I’m Still Standing", 2, 1), ("The Impression That I Get", 1, 1), 
	("Industry Baby", 4, 0), ("Land of 1000 Dances", 4, 0);
INSERT INTO song VALUES ("Livin’ on a Prayer", 2, 0), ("Louie, Louie", 5, 0), ("My House", 1, 1), ("Never Going to Give You Up", 3, 1), ("Party in the U.S.A.", 5, 1), ("Poker Face", 3, 1), ("Pompeii", 3, 0), ("Runaway Baby", 4, 1), 
	("September", 3, 1), ("Seven Nation Army", 3, 0), ("Shout It Out", 5, 1);
INSERT INTO song VALUES ("Shut up and Dance", 3, 1), ("Some Nights", 1, 0), ("Starships", 5, 1), ("Sweet Caroline", 2, 1), ("Take On Me", 4, 1), 
	("Thnks Fr Th Mmrs", 3, 1), ("Trumpets", 3, 1), ("Uprising", 2, 1), ("Uptown Funk", 5, 1), ("Viva La Vida", 2, 0), ("White and Blue", 4, 1);


DROP TABLE IF EXISTS preferences;
CREATE TABLE preferences (
	netId INT NOT NULL,
    song_title VARCHAR(255) NOT NULL,
    score INT,
    PRIMARY KEY(netId, song_title),
    CONSTRAINT preferences_ibfk_1 FOREIGN KEY (netId) REFERENCES members (netId),
    CONSTRAINT preferences_ibfk_2 FOREIGN KEY (song_title) REFERENCES song (song_title)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE utf8mb4_unicode_ci;

-- INSERT VALUES FOR PREFERENCES
INSERT INTO preferences VALUES (1, "Bad Romance", 1), (1, "High School Never Ends", 2), (1, "Hey! Baby", 3), (2, "Uptown Funk", 1), 
	(2, "Holiday", 2), (2, "Trumpets", 3), (3, "Final Countdown", 1), (3, "Louie, Louie", 2), (3, "Dynamite", 3), (4, "High Hopes", 1),
    (4, "Louie, Louie", 2), (4, "All the Small Things", 3), (5, "Take On Me", 1), (5, "Industry Baby", 2), (5, "Viva La Vida", 3), 
    (6, "Seven Nation Army", 1), (6, "Havana", 2), (6, "Don’t Stop Believin", 3), (7, "Pompeii", 1), (7, "Take On Me", 2), (7, "Party in the U.S.A.", 3),
    (8, "Runaway Baby", 1), (8, "Pompeii", 2), (8, "Trumpets", 3), (9, "Bad Romance", 1), (9, "Trumpets", 2), (9, "Some Nights", 3), (10, "Viva La Vida", 1), 
    (10, "Hooked on a Feeling", 2), (10, "Seven Nation Army", 3);
INSERT INTO preferences VALUES (11, "Blinding Lights", 1), (11, "Some Nights", 2), (11, "September", 3), (12, "Dynamite", 1), (12, "High Hopes", 2),
	(12, "867-5309/Jenny", 3), (13, "Blinding Lights", 1), (13, "Never Going to Give You Up", 2), (13, "High Hopes", 3), (14, "Take On Me", 1), 
    (14, "Fat Bottomed Girls", 2), (14, "Handclap", 3), (15, "Funky Town", 1), (15, "Final Countdown", 2), (15, "Hey! Baby", 3), (16, "867-5309/Jenny", 1),
    (16, "Don’t Stop Believin", 2), (16, "Final Countdown", 3), (17, "Final Countdown", 1), (17, "Fat Bottomed Girls", 2), (17, "All the Small Things", 3),
    (18, "Viva La Vida", 1), (18, "Trumpets", 2), (18, "Bad Romance", 3), (19, "Seven Nation Army", 1), (19, "Carry on Wayward Son", 2), (19, "Bad Romance", 3),
    (20, "Shout It Out", 1), (20, "I Want You Back", 2), (20, "Industry Baby", 3);
INSERT INTO preferences VALUES (21, "Starships", 1), (21, "I Want You Back", 2), (21, "Final Countdown", 3), 
    (22, "Fat Bottomed Girls", 1), (22, "Blinding Lights", 2), (22, "I’m Still Standing", 3), (23, "Some Nights", 1), (23, "Louie, Louie", 2), (23, "Good 4 U", 3),
    (24, "All the Small Things", 1), (24, "867-5309/Jenny", 2), (24, "Starships", 3), (25, "Bad Romance", 1), (25, "Land of 1000 Dances", 2), 
    (25, "Livin’ on a Prayer", 3), (26, "Runaway Baby", 1), (26, "My House", 2), (26, "Never Going to Give You Up", 3), (27, "I Want You Back", 1), 
    (27, "Good 4 U", 2), (27, "Hey Song", 3), (28, "Trumpets", 1), (28, "White and Blue", 2), (28, "I Knew You Were Trouble", 3), (29, "Pompeii", 1), 
    (29, "White and Blue", 2), (29, "I Want You Back", 3), (30, "Never Going to Give You Up", 1), (30, "Seven Nation Army", 2), (30, "Viva La Vida", 3);
INSERT INTO preferences VALUES (31, "Uptown Funk", 1), (31, "Industry Baby", 2), (31, "Trumpets", 3), (32, "Good 4 U", 1), (32, "Uprising", 2), (32, "Funky Town", 3), 
	(33, "Land of 1000 Dances", 1), (33, "Pompeii", 2), (33, "Build me up Buttercup", 3), (34, "Funky Town", 1), (34, "Poker Face", 2), (34, "Good 4 U", 3),
    (35, "Some Nights", 1), (35, "Holiday", 2), (35, "Uprising", 3), (36, "High School Never Ends", 1), (36, "I’m Still Standing", 2), (36, "Seven Nation Army", 3),
    (37, "Sweet Caroline", 1), (37, "Pompeii", 2), (37, "Party in the U.S.A.", 3), (38, "Never Going to Give You Up", 1), (38, "Viva La Vida", 2), 
    (38, "Carry on Wayward Son", 3), (39, "Take On Me", 1), (39, "Don’t Stop Believin", 2), (39, "Holiday", 3), (40, "Hooked on a Feeling", 1), (40, "Trumpets", 2),
    (40, "I Want You Back", 3);

DROP TABLE IF EXISTS folderSong;
CREATE TABLE folderSong (
	folderId INT NOT NULL,
    song_title VARCHAR(255) NOT NULL,
    PRIMARY KEY(folderId, song_title),
    CONSTRAINT folderSong_ibfk_1 FOREIGN KEY(folderId) REFERENCES folder(folderId),
    CONSTRAINT folderSong_ibfk_2 FOREIGN KEY(song_title) REFERENCES song(song_title)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE utf8mb4_unicode_ci;

-- INSERT VALUES FOR FOLDERSONG
INSERT INTO folderSong VALUES (1001, "25 or 6 to 4"), (1001, "867-5309/Jenny"), (1001, "All the Small Things"), (1001, "Bad Romance"), (1001, "Blinding Lights"), 
(1001, "Build me up Buttercup"), (1001, "Carry on Wayward Son"), (1001, "Confident"), (1001, "Crazy Train"), (1001, "Dancing Queen"), 
(1001, "Don’t Stop Believin"), (1001, "Dynamite"), (1001, "Every time we touch"), (1001, "Fat Bottomed Girls"), (1001, "Final Countdown"), 
(1001, "Funky Town"), (1001, "Good 4 U"), (1001, "Handclap"), (1001, "Havana"), (1001, "Hey! Baby"), (1001, "Hey Song"), 
(1001, "High Hopes"), (1001, "High School Never Ends"), (1001, "Holiday"), (1001, "Hooked on a Feeling"), (1001, "How Far We’ve Come"), 
(1001, "I Knew You Were Trouble"), (1001, "I Want You Back"), (1001, "I’m Still Standing"), (1001, "The Impression That I Get"), 
(1001, "Industry Baby"), (1001, "Land of 1000 Dances"), (1001, "Livin’ on a Prayer"), (1001, "Louie, Louie"), (1001, "My House"), 
(1001, "Never Going to Give You Up"), (1001, "Party in the U.S.A."), (1001, "Poker Face"), (1001, "Pompeii"), (1001, "Runaway Baby"), 
(1001, "September"), (1001, "Seven Nation Army"), (1001, "Shout It Out"), (1001, "Shut up and Dance"), (1001, "Some Nights"), 
(1001, "Starships"), (1001, "Sweet Caroline"), (1001, "Take On Me"), (1001, "Thnks Fr Th Mmrs"), (1001, "Trumpets"), (1001, "Uprising"), 
(1001, "Uptown Funk"), (1001, "Viva La Vida"), (1001, "White and Blue");
INSERT INTO folderSong VALUES (1002, "25 or 6 to 4"), (1002, "867-5309/Jenny"), 
(1002, "All the Small Things"), (1002, "Bad Romance"), (1002, "Blinding Lights"), (1002, "Build me up Buttercup"), (1002, "Carry on Wayward Son"), 
(1002, "Confident"), (1002, "Crazy Train"), (1002, "Dancing Queen"), (1002, "Don’t Stop Believin"), (1002, "Dynamite"), 
(1002, "Every time we touch"), (1002, "Fat Bottomed Girls"), (1002, "Final Countdown"), (1002, "Funky Town"), (1002, "Good 4 U"), 
(1002, "Handclap"), (1002, "Havana"), (1002, "Hey! Baby"), (1002, "Hey Song"), (1002, "High Hopes"), (1002, "High School Never Ends"), 
(1002, "Holiday"), (1002, "Hooked on a Feeling"), (1002, "How Far We’ve Come"), (1002, "I Knew You Were Trouble"), (1002, "I Want You Back"), 
(1002, "I’m Still Standing"), (1002, "The Impression That I Get"), (1002, "Industry Baby"), (1002, "Land of 1000 Dances"), 
(1002, "Livin’ on a Prayer"), (1002, "Louie, Louie"), (1002, "My House"), (1002, "Never Going to Give You Up"), (1002, "Party in the U.S.A."), 
(1002, "Poker Face"), (1002, "Pompeii"), (1002, "Runaway Baby"), (1002, "September"), (1002, "Seven Nation Army"), (1002, "Shout It Out"), 
(1002, "Shut up and Dance"), (1002, "Some Nights"), (1002, "Starships"), (1002, "Sweet Caroline"), (1002, "Take On Me"), 
(1002, "Thnks Fr Th Mmrs"), (1002, "Trumpets"), (1002, "Uprising"), (1002, "Uptown Funk"), (1002, "Viva La Vida"), (1002, "White and Blue");
INSERT INTO folderSong VALUES 
(1003, "25 or 6 to 4"), (1003, "867-5309/Jenny"), (1003, "All the Small Things"), (1003, "Bad Romance"), (1003, "Blinding Lights"), 
(1003, "Build me up Buttercup"), (1003, "Carry on Wayward Son"), (1003, "Confident"), (1003, "Crazy Train"), (1003, "Dancing Queen"), 
(1003, "Don’t Stop Believin"), (1003, "Dynamite"), (1003, "Every time we touch"), (1003, "Fat Bottomed Girls"), (1003, "Final Countdown"), 
(1003, "Funky Town"), (1003, "Good 4 U"), (1003, "Handclap"), (1003, "Havana"), (1003, "Hey! Baby"), (1003, "Hey Song"), 
(1003, "High Hopes"), (1003, "High School Never Ends"), (1003, "Holiday"), (1003, "Hooked on a Feeling"), (1003, "How Far We’ve Come"), 
(1003, "I Knew You Were Trouble"), (1003, "I Want You Back"), (1003, "I’m Still Standing"), (1003, "The Impression That I Get"), 
(1003, "Industry Baby"), (1003, "Land of 1000 Dances"), (1003, "Livin’ on a Prayer"), (1003, "Louie, Louie"), (1003, "My House"), 
(1003, "Never Going to Give You Up"), (1003, "Party in the U.S.A."), (1003, "Poker Face"), (1003, "Pompeii"), (1003, "Runaway Baby"), 
(1003, "September"), (1003, "Seven Nation Army"), (1003, "Shout It Out"), (1003, "Shut up and Dance"), (1003, "Some Nights"), 
(1003, "Starships"), (1003, "Sweet Caroline"), (1003, "Take On Me"), (1003, "Thnks Fr Th Mmrs"), (1003, "Trumpets"), (1003, "Uprising"), 
(1003, "Uptown Funk"), (1003, "Viva La Vida"), (1003, "White and Blue");
INSERT INTO folderSong VALUES (1004, "25 or 6 to 4"), (1004, "867-5309/Jenny"), 
(1004, "All the Small Things"), (1004, "Bad Romance"), (1004, "Blinding Lights"), (1004, "Build me up Buttercup"), (1004, "Carry on Wayward Son"), 
(1004, "Confident"), (1004, "Crazy Train"), (1004, "Dancing Queen"), (1004, "Don’t Stop Believin"), (1004, "Dynamite"), 
(1004, "Every time we touch"), (1004, "Fat Bottomed Girls"), (1004, "Final Countdown"), (1004, "Funky Town"), (1004, "Good 4 U"), 
(1004, "Handclap"), (1004, "Havana"), (1004, "Hey! Baby"), (1004, "Hey Song"), (1004, "High Hopes"), (1004, "High School Never Ends"), 
(1004, "Holiday"), (1004, "Hooked on a Feeling"), (1004, "How Far We’ve Come"), (1004, "I Knew You Were Trouble"), (1004, "I Want You Back"), 
(1004, "I’m Still Standing"), (1004, "The Impression That I Get"), (1004, "Industry Baby"), (1004, "Land of 1000 Dances"), 
(1004, "Livin’ on a Prayer"), (1004, "Louie, Louie"), (1004, "My House"), (1004, "Never Going to Give You Up"), (1004, "Party in the U.S.A."), 
(1004, "Poker Face"), (1004, "Pompeii"), (1004, "Runaway Baby"), (1004, "September"), (1004, "Seven Nation Army"), (1004, "Shout It Out"), 
(1004, "Shut up and Dance"), (1004, "Some Nights"), (1004, "Starships"), (1004, "Sweet Caroline"), (1004, "Take On Me"), 
(1004, "Thnks Fr Th Mmrs"), (1004, "Trumpets"), (1004, "Uprising"), (1004, "Uptown Funk"), (1004, "Viva La Vida"), (1004, "White and Blue");
INSERT INTO folderSong VALUES 
(1005, "25 or 6 to 4"), (1005, "867-5309/Jenny"), (1005, "All the Small Things"), (1005, "Bad Romance"), (1005, "Blinding Lights"), 
(1005, "Build me up Buttercup"), (1005, "Carry on Wayward Son"), (1005, "Confident"), (1005, "Crazy Train"), (1005, "Dancing Queen"), 
(1005, "Don’t Stop Believin"), (1005, "Dynamite"), (1005, "Every time we touch"), (1005, "Fat Bottomed Girls"), (1005, "Final Countdown"), 
(1005, "Funky Town"), (1005, "Good 4 U"), (1005, "Handclap"), (1005, "Havana"), (1005, "Hey! Baby"), (1005, "Hey Song"), 
(1005, "High Hopes"), (1005, "High School Never Ends"), (1005, "Holiday"), (1005, "Hooked on a Feeling"), (1005, "How Far We’ve Come"), 
(1005, "I Knew You Were Trouble"), (1005, "I Want You Back"), (1005, "I’m Still Standing"), (1005, "The Impression That I Get"), 
(1005, "Industry Baby"), (1005, "Land of 1000 Dances"), (1005, "Livin’ on a Prayer"), (1005, "Louie, Louie"), (1005, "My House"), 
(1005, "Never Going to Give You Up"), (1005, "Party in the U.S.A."), (1005, "Poker Face"), (1005, "Pompeii"), (1005, "Runaway Baby"), 
(1005, "September"), (1005, "Seven Nation Army"), (1005, "Shout It Out"), (1005, "Shut up and Dance"), (1005, "Some Nights"), 
(1005, "Starships"), (1005, "Sweet Caroline"), (1005, "Take On Me"), (1005, "Thnks Fr Th Mmrs"), (1005, "Trumpets"), (1005, "Uprising"), 
(1005, "Uptown Funk"), (1005, "Viva La Vida"), (1005, "White and Blue");
INSERT INTO folderSong VALUES (1006, "25 or 6 to 4"), (1006, "867-5309/Jenny"), 
(1006, "All the Small Things"), (1006, "Bad Romance"), (1006, "Blinding Lights"), (1006, "Build me up Buttercup"), (1006, "Carry on Wayward Son"), 
(1006, "Confident"), (1006, "Crazy Train"), (1006, "Dancing Queen"), (1006, "Don’t Stop Believin"), (1006, "Dynamite"), 
(1006, "Every time we touch"), (1006, "Fat Bottomed Girls"), (1006, "Final Countdown"), (1006, "Funky Town"), (1006, "Good 4 U"), 
(1006, "Handclap"), (1006, "Havana"), (1006, "Hey! Baby"), (1006, "Hey Song"), (1006, "High Hopes"), (1006, "High School Never Ends"), 
(1006, "Holiday"), (1006, "Hooked on a Feeling"), (1006, "How Far We’ve Come"), (1006, "I Knew You Were Trouble"), (1006, "I Want You Back"), 
(1006, "I’m Still Standing"), (1006, "The Impression That I Get"), (1006, "Industry Baby"), (1006, "Land of 1000 Dances"), 
(1006, "Livin’ on a Prayer"), (1006, "Louie, Louie"), (1006, "My House"), (1006, "Never Going to Give You Up"), (1006, "Party in the U.S.A."), 
(1006, "Poker Face"), (1006, "Pompeii"), (1006, "Runaway Baby"), (1006, "September"), (1006, "Seven Nation Army"), (1006, "Shout It Out"), 
(1006, "Shut up and Dance"), (1006, "Some Nights"), (1006, "Starships"), (1006, "Sweet Caroline"), (1006, "Take On Me"), 
(1006, "Thnks Fr Th Mmrs"), (1006, "Trumpets"), (1006, "Uprising"), (1006, "Uptown Funk"), (1006, "Viva La Vida"), (1006, "White and Blue");
INSERT INTO folderSong VALUES 
(1007, "25 or 6 to 4"), (1007, "867-5309/Jenny"), (1007, "All the Small Things"), (1007, "Bad Romance"), (1007, "Blinding Lights"), 
(1007, "Build me up Buttercup"), (1007, "Carry on Wayward Son"), (1007, "Confident"), (1007, "Crazy Train"), (1007, "Dancing Queen"), 
(1007, "Don’t Stop Believin"), (1007, "Dynamite"), (1007, "Every time we touch"), (1007, "Fat Bottomed Girls"), (1007, "Final Countdown"), 
(1007, "Funky Town"), (1007, "Good 4 U"), (1007, "Handclap"), (1007, "Havana"), (1007, "Hey! Baby"), (1007, "Hey Song"), 
(1007, "High Hopes"), (1007, "High School Never Ends"), (1007, "Holiday"), (1007, "Hooked on a Feeling"), (1007, "How Far We’ve Come"), 
(1007, "I Knew You Were Trouble"), (1007, "I Want You Back"), (1007, "I’m Still Standing"), (1007, "The Impression That I Get"), 
(1007, "Industry Baby"), (1007, "Land of 1000 Dances"), (1007, "Livin’ on a Prayer"), (1007, "Louie, Louie"), (1007, "My House"), 
(1007, "Never Going to Give You Up"), (1007, "Party in the U.S.A."), (1007, "Poker Face"), (1007, "Pompeii"), (1007, "Runaway Baby"), 
(1007, "September"), (1007, "Seven Nation Army"), (1007, "Shout It Out"), (1007, "Shut up and Dance"), (1007, "Some Nights"), 
(1007, "Starships"), (1007, "Sweet Caroline"), (1007, "Take On Me"), (1007, "Thnks Fr Th Mmrs"), (1007, "Trumpets"), (1007, "Uprising"), 
(1007, "Uptown Funk"), (1007, "Viva La Vida"), (1007, "White and Blue");
INSERT INTO folderSong VALUES (1008, "25 or 6 to 4"), (1008, "867-5309/Jenny"), 
(1008, "All the Small Things"), (1008, "Bad Romance"), (1008, "Blinding Lights"), (1008, "Build me up Buttercup"), (1008, "Carry on Wayward Son"), 
(1008, "Confident"), (1008, "Crazy Train"), (1008, "Dancing Queen"), (1008, "Don’t Stop Believin"), (1008, "Dynamite"), 
(1008, "Every time we touch"), (1008, "Fat Bottomed Girls"), (1008, "Final Countdown"), (1008, "Funky Town"), (1008, "Good 4 U"), 
(1008, "Handclap"), (1008, "Havana"), (1008, "Hey! Baby"), (1008, "Hey Song"), (1008, "High Hopes"), (1008, "High School Never Ends"), 
(1008, "Holiday"), (1008, "Hooked on a Feeling"), (1008, "How Far We’ve Come"), (1008, "I Knew You Were Trouble"), (1008, "I Want You Back"), 
(1008, "I’m Still Standing"), (1008, "The Impression That I Get"), (1008, "Industry Baby"), (1008, "Land of 1000 Dances"), 
(1008, "Livin’ on a Prayer"), (1008, "Louie, Louie"), (1008, "My House"), (1008, "Never Going to Give You Up"), (1008, "Party in the U.S.A."), 
(1008, "Poker Face"), (1008, "Pompeii"), (1008, "Runaway Baby"), (1008, "September"), (1008, "Seven Nation Army"), (1008, "Shout It Out"), 
(1008, "Shut up and Dance"), (1008, "Some Nights"), (1008, "Starships"), (1008, "Sweet Caroline"), (1008, "Take On Me"), 
(1008, "Thnks Fr Th Mmrs"), (1008, "Trumpets"), (1008, "Uprising"), (1008, "Uptown Funk"), (1008, "Viva La Vida"), (1008, "White and Blue");
INSERT INTO folderSong VALUES 
(1009, "25 or 6 to 4"), (1009, "867-5309/Jenny"), (1009, "All the Small Things"), (1009, "Bad Romance"), (1009, "Blinding Lights"), 
(1009, "Build me up Buttercup"), (1009, "Carry on Wayward Son"), (1009, "Confident"), (1009, "Crazy Train"), (1009, "Dancing Queen"), 
(1009, "Don’t Stop Believin"), (1009, "Dynamite"), (1009, "Every time we touch"), (1009, "Fat Bottomed Girls"), (1009, "Final Countdown"), 
(1009, "Funky Town"), (1009, "Good 4 U"), (1009, "Handclap"), (1009, "Havana"), (1009, "Hey! Baby"), (1009, "Hey Song"), 
(1009, "High Hopes"), (1009, "High School Never Ends"), (1009, "Holiday"), (1009, "Hooked on a Feeling"), (1009, "How Far We’ve Come"), 
(1009, "I Knew You Were Trouble"), (1009, "I Want You Back"), (1009, "I’m Still Standing"), (1009, "The Impression That I Get"), 
(1009, "Industry Baby"), (1009, "Land of 1000 Dances"), (1009, "Livin’ on a Prayer"), (1009, "Louie, Louie"), (1009, "My House"), 
(1009, "Never Going to Give You Up"), (1009, "Party in the U.S.A."), (1009, "Poker Face"), (1009, "Pompeii"), (1009, "Runaway Baby"), 
(1009, "September"), (1009, "Seven Nation Army"), (1009, "Shout It Out"), (1009, "Shut up and Dance"), (1009, "Some Nights"), 
(1009, "Starships"), (1009, "Sweet Caroline"), (1009, "Take On Me"), (1009, "Thnks Fr Th Mmrs"), (1009, "Trumpets"), (1009, "Uprising"), 
(1009, "Uptown Funk"), (1009, "Viva La Vida"), (1009, "White and Blue");
INSERT INTO folderSong VALUES (1010, "25 or 6 to 4"), (1010, "867-5309/Jenny"), 
(1010, "All the Small Things"), (1010, "Bad Romance"), (1010, "Blinding Lights"), (1010, "Build me up Buttercup"), (1010, "Carry on Wayward Son"), 
(1010, "Confident"), (1010, "Crazy Train"), (1010, "Dancing Queen"), (1010, "Don’t Stop Believin"), (1010, "Dynamite"), 
(1010, "Every time we touch"), (1010, "Fat Bottomed Girls"), (1010, "Final Countdown"), (1010, "Funky Town"), (1010, "Good 4 U"), 
(1010, "Handclap"), (1010, "Havana"), (1010, "Hey! Baby"), (1010, "Hey Song"), (1010, "High Hopes"), (1010, "High School Never Ends"), 
(1010, "Holiday"), (1010, "Hooked on a Feeling"), (1010, "How Far We’ve Come"), (1010, "I Knew You Were Trouble"), (1010, "I Want You Back"), 
(1010, "I’m Still Standing"), (1010, "The Impression That I Get"), (1010, "Industry Baby"), (1010, "Land of 1000 Dances"), 
(1010, "Livin’ on a Prayer"), (1010, "Louie, Louie"), (1010, "My House"), (1010, "Never Going to Give You Up"), (1010, "Party in the U.S.A."), 
(1010, "Poker Face"), (1010, "Pompeii"), (1010, "Runaway Baby"), (1010, "September"), (1010, "Seven Nation Army"), (1010, "Shout It Out"), 
(1010, "Shut up and Dance"), (1010, "Some Nights"), (1010, "Starships"), (1010, "Sweet Caroline"), (1010, "Take On Me"), 
(1010, "Thnks Fr Th Mmrs"), (1010, "Trumpets"), (1010, "Uprising"), (1010, "Uptown Funk"), (1010, "Viva La Vida"), (1010, "White and Blue");
INSERT INTO folderSong VALUES 
(1011, "25 or 6 to 4"), (1011, "867-5309/Jenny"), (1011, "All the Small Things"), (1011, "Bad Romance"), (1011, "Blinding Lights"), 
(1011, "Build me up Buttercup"), (1011, "Carry on Wayward Son"), (1011, "Confident"), (1011, "Crazy Train"), (1011, "Dancing Queen"), 
(1011, "Don’t Stop Believin"), (1011, "Dynamite"), (1011, "Every time we touch"), (1011, "Fat Bottomed Girls"), (1011, "Final Countdown"), 
(1011, "Funky Town"), (1011, "Good 4 U"), (1011, "Handclap"), (1011, "Havana"), (1011, "Hey! Baby"), (1011, "Hey Song"), 
(1011, "High Hopes"), (1011, "High School Never Ends"), (1011, "Holiday"), (1011, "Hooked on a Feeling"), (1011, "How Far We’ve Come"), 
(1011, "I Knew You Were Trouble"), (1011, "I Want You Back"), (1011, "I’m Still Standing"), (1011, "The Impression That I Get"), 
(1011, "Industry Baby"), (1011, "Land of 1000 Dances"), (1011, "Livin’ on a Prayer"), (1011, "Louie, Louie"), (1011, "My House"), 
(1011, "Never Going to Give You Up"), (1011, "Party in the U.S.A."), (1011, "Poker Face"), (1011, "Pompeii"), (1011, "Runaway Baby"), 
(1011, "September"), (1011, "Seven Nation Army"), (1011, "Shout It Out"), (1011, "Shut up and Dance"), (1011, "Some Nights"), 
(1011, "Starships"), (1011, "Sweet Caroline"), (1011, "Take On Me"), (1011, "Thnks Fr Th Mmrs"), (1011, "Trumpets"), (1011, "Uprising"), 
(1011, "Uptown Funk"), (1011, "Viva La Vida"), (1011, "White and Blue");
INSERT INTO folderSong VALUES (1012, "25 or 6 to 4"), (1012, "867-5309/Jenny"), 
(1012, "All the Small Things"), (1012, "Bad Romance"), (1012, "Blinding Lights"), (1012, "Build me up Buttercup"), (1012, "Carry on Wayward Son"), 
(1012, "Confident"), (1012, "Crazy Train"), (1012, "Dancing Queen"), (1012, "Don’t Stop Believin"), (1012, "Dynamite"), 
(1012, "Every time we touch"), (1012, "Fat Bottomed Girls"), (1012, "Final Countdown"), (1012, "Funky Town"), (1012, "Good 4 U"), 
(1012, "Handclap"), (1012, "Havana"), (1012, "Hey! Baby"), (1012, "Hey Song"), (1012, "High Hopes"), (1012, "High School Never Ends"), 
(1012, "Holiday"), (1012, "Hooked on a Feeling"), (1012, "How Far We’ve Come"), (1012, "I Knew You Were Trouble"), (1012, "I Want You Back"), 
(1012, "I’m Still Standing"), (1012, "The Impression That I Get"), (1012, "Industry Baby"), (1012, "Land of 1000 Dances"), 
(1012, "Livin’ on a Prayer"), (1012, "Louie, Louie"), (1012, "My House"), (1012, "Never Going to Give You Up"), (1012, "Party in the U.S.A."), 
(1012, "Poker Face"), (1012, "Pompeii"), (1012, "Runaway Baby"), (1012, "September"), (1012, "Seven Nation Army"), (1012, "Shout It Out"), 
(1012, "Shut up and Dance"), (1012, "Some Nights"), (1012, "Starships"), (1012, "Sweet Caroline"), (1012, "Take On Me"), 
(1012, "Thnks Fr Th Mmrs"), (1012, "Trumpets"), (1012, "Uprising"), (1012, "Uptown Funk"), (1012, "Viva La Vida"), (1012, "White and Blue");
INSERT INTO folderSong VALUES 
(1013, "25 or 6 to 4"), (1013, "867-5309/Jenny"), (1013, "All the Small Things"), (1013, "Bad Romance"), (1013, "Blinding Lights"), 
(1013, "Build me up Buttercup"), (1013, "Carry on Wayward Son"), (1013, "Confident"), (1013, "Crazy Train"), (1013, "Dancing Queen"), 
(1013, "Don’t Stop Believin"), (1013, "Dynamite"), (1013, "Every time we touch"), (1013, "Fat Bottomed Girls"), (1013, "Final Countdown"), 
(1013, "Funky Town"), (1013, "Good 4 U"), (1013, "Handclap"), (1013, "Havana"), (1013, "Hey! Baby"), (1013, "Hey Song"), 
(1013, "High Hopes"), (1013, "High School Never Ends"), (1013, "Holiday"), (1013, "Hooked on a Feeling"), (1013, "How Far We’ve Come"), 
(1013, "I Knew You Were Trouble"), (1013, "I Want You Back"), (1013, "I’m Still Standing"), (1013, "The Impression That I Get"), 
(1013, "Industry Baby"), (1013, "Land of 1000 Dances"), (1013, "Livin’ on a Prayer"), (1013, "Louie, Louie"), (1013, "My House"), 
(1013, "Never Going to Give You Up"), (1013, "Party in the U.S.A."), (1013, "Poker Face"), (1013, "Pompeii"), (1013, "Runaway Baby"), 
(1013, "September"), (1013, "Seven Nation Army"), (1013, "Shout It Out"), (1013, "Shut up and Dance"), (1013, "Some Nights"), 
(1013, "Starships"), (1013, "Sweet Caroline"), (1013, "Take On Me"), (1013, "Thnks Fr Th Mmrs"), (1013, "Trumpets"), (1013, "Uprising"), 
(1013, "Uptown Funk"), (1013, "Viva La Vida"), (1013, "White and Blue");
INSERT INTO folderSong VALUES (1014, "25 or 6 to 4"), (1014, "867-5309/Jenny"), 
(1014, "All the Small Things"), (1014, "Bad Romance"), (1014, "Blinding Lights"), (1014, "Build me up Buttercup"), (1014, "Carry on Wayward Son"), 
(1014, "Confident"), (1014, "Crazy Train"), (1014, "Dancing Queen"), (1014, "Don’t Stop Believin"), (1014, "Dynamite"), 
(1014, "Every time we touch"), (1014, "Fat Bottomed Girls"), (1014, "Final Countdown"), (1014, "Funky Town"), (1014, "Good 4 U"), 
(1014, "Handclap"), (1014, "Havana"), (1014, "Hey! Baby"), (1014, "Hey Song"), (1014, "High Hopes"), (1014, "High School Never Ends"), 
(1014, "Holiday"), (1014, "Hooked on a Feeling"), (1014, "How Far We’ve Come"), (1014, "I Knew You Were Trouble"), (1014, "I Want You Back"), 
(1014, "I’m Still Standing"), (1014, "The Impression That I Get"), (1014, "Industry Baby"), (1014, "Land of 1000 Dances"), 
(1014, "Livin’ on a Prayer"), (1014, "Louie, Louie"), (1014, "My House"), (1014, "Never Going to Give You Up"), (1014, "Party in the U.S.A."), 
(1014, "Poker Face"), (1014, "Pompeii"), (1014, "Runaway Baby"), (1014, "September"), (1014, "Seven Nation Army"), (1014, "Shout It Out"), 
(1014, "Shut up and Dance"), (1014, "Some Nights"), (1014, "Starships"), (1014, "Sweet Caroline"), (1014, "Take On Me"), 
(1014, "Thnks Fr Th Mmrs"), (1014, "Trumpets"), (1014, "Uprising"), (1014, "Uptown Funk"), (1014, "Viva La Vida"), (1014, "White and Blue");
INSERT INTO folderSong VALUES 
(1015, "25 or 6 to 4"), (1015, "867-5309/Jenny"), (1015, "All the Small Things"), (1015, "Bad Romance"), (1015, "Blinding Lights"), 
(1015, "Build me up Buttercup"), (1015, "Carry on Wayward Son"), (1015, "Confident"), (1015, "Crazy Train"), (1015, "Dancing Queen"), 
(1015, "Don’t Stop Believin"), (1015, "Dynamite"), (1015, "Every time we touch"), (1015, "Fat Bottomed Girls"), (1015, "Final Countdown"), 
(1015, "Funky Town"), (1015, "Good 4 U"), (1015, "Handclap"), (1015, "Havana"), (1015, "Hey! Baby"), (1015, "Hey Song"), 
(1015, "High Hopes"), (1015, "High School Never Ends"), (1015, "Holiday"), (1015, "Hooked on a Feeling"), (1015, "How Far We’ve Come"), 
(1015, "I Knew You Were Trouble"), (1015, "I Want You Back"), (1015, "I’m Still Standing"), (1015, "The Impression That I Get"), 
(1015, "Industry Baby"), (1015, "Land of 1000 Dances"), (1015, "Livin’ on a Prayer"), (1015, "Louie, Louie"), (1015, "My House"), 
(1015, "Never Going to Give You Up"), (1015, "Party in the U.S.A."), (1015, "Poker Face"), (1015, "Pompeii"), (1015, "Runaway Baby"), 
(1015, "September"), (1015, "Seven Nation Army"), (1015, "Shout It Out"), (1015, "Shut up and Dance"), (1015, "Some Nights"), 
(1015, "Starships"), (1015, "Sweet Caroline"), (1015, "Take On Me"), (1015, "Thnks Fr Th Mmrs"), (1015, "Trumpets"), (1015, "Uprising"), 
(1015, "Uptown Funk"), (1015, "Viva La Vida"), (1015, "White and Blue");
INSERT INTO folderSong VALUES (1016, "25 or 6 to 4"), (1016, "867-5309/Jenny"), 
(1016, "All the Small Things"), (1016, "Bad Romance"), (1016, "Blinding Lights"), (1016, "Build me up Buttercup"), (1016, "Carry on Wayward Son"), 
(1016, "Confident"), (1016, "Crazy Train"), (1016, "Dancing Queen"), (1016, "Don’t Stop Believin"), (1016, "Dynamite"), 
(1016, "Every time we touch"), (1016, "Fat Bottomed Girls"), (1016, "Final Countdown"), (1016, "Funky Town"), (1016, "Good 4 U"), 
(1016, "Handclap"), (1016, "Havana"), (1016, "Hey! Baby"), (1016, "Hey Song"), (1016, "High Hopes"), (1016, "High School Never Ends"), 
(1016, "Holiday"), (1016, "Hooked on a Feeling"), (1016, "How Far We’ve Come"), (1016, "I Knew You Were Trouble"), (1016, "I Want You Back"), 
(1016, "I’m Still Standing"), (1016, "The Impression That I Get"), (1016, "Industry Baby"), (1016, "Land of 1000 Dances"), 
(1016, "Livin’ on a Prayer"), (1016, "Louie, Louie"), (1016, "My House"), (1016, "Never Going to Give You Up"), (1016, "Party in the U.S.A."), 
(1016, "Poker Face"), (1016, "Pompeii"), (1016, "Runaway Baby"), (1016, "September"), (1016, "Seven Nation Army"), (1016, "Shout It Out"), 
(1016, "Shut up and Dance"), (1016, "Some Nights"), (1016, "Starships"), (1016, "Sweet Caroline"), (1016, "Take On Me"), 
(1016, "Thnks Fr Th Mmrs"), (1016, "Trumpets"), (1016, "Uprising"), (1016, "Uptown Funk"), (1016, "Viva La Vida"), (1016, "White and Blue");
INSERT INTO folderSong VALUES 
(1017, "25 or 6 to 4"), (1017, "867-5309/Jenny"), (1017, "All the Small Things"), (1017, "Bad Romance"), (1017, "Blinding Lights"), 
(1017, "Build me up Buttercup"), (1017, "Carry on Wayward Son"), (1017, "Confident"), (1017, "Crazy Train"), (1017, "Dancing Queen"), 
(1017, "Don’t Stop Believin"), (1017, "Dynamite"), (1017, "Every time we touch"), (1017, "Fat Bottomed Girls"), (1017, "Final Countdown"), 
(1017, "Funky Town"), (1017, "Good 4 U"), (1017, "Handclap"), (1017, "Havana"), (1017, "Hey! Baby"), (1017, "Hey Song"), 
(1017, "High Hopes"), (1017, "High School Never Ends"), (1017, "Holiday"), (1017, "Hooked on a Feeling"), (1017, "How Far We’ve Come"), 
(1017, "I Knew You Were Trouble"), (1017, "I Want You Back"), (1017, "I’m Still Standing"), (1017, "The Impression That I Get"), 
(1017, "Industry Baby"), (1017, "Land of 1000 Dances"), (1017, "Livin’ on a Prayer"), (1017, "Louie, Louie"), (1017, "My House"), 
(1017, "Never Going to Give You Up"), (1017, "Party in the U.S.A."), (1017, "Poker Face"), (1017, "Pompeii"), (1017, "Runaway Baby"), 
(1017, "September"), (1017, "Seven Nation Army"), (1017, "Shout It Out"), (1017, "Shut up and Dance"), (1017, "Some Nights"), 
(1017, "Starships"), (1017, "Sweet Caroline"), (1017, "Take On Me"), (1017, "Thnks Fr Th Mmrs"), (1017, "Trumpets"), (1017, "Uprising"), 
(1017, "Uptown Funk"), (1017, "Viva La Vida"), (1017, "White and Blue");
INSERT INTO folderSong VALUES (1018, "25 or 6 to 4"), (1018, "867-5309/Jenny"), 
(1018, "All the Small Things"), (1018, "Bad Romance"), (1018, "Blinding Lights"), (1018, "Build me up Buttercup"), (1018, "Carry on Wayward Son"), 
(1018, "Confident"), (1018, "Crazy Train"), (1018, "Dancing Queen"), (1018, "Don’t Stop Believin"), (1018, "Dynamite"), 
(1018, "Every time we touch"), (1018, "Fat Bottomed Girls"), (1018, "Final Countdown"), (1018, "Funky Town"), (1018, "Good 4 U"), 
(1018, "Handclap"), (1018, "Havana"), (1018, "Hey! Baby"), (1018, "Hey Song"), (1018, "High Hopes"), (1018, "High School Never Ends"), 
(1018, "Holiday"), (1018, "Hooked on a Feeling"), (1018, "How Far We’ve Come"), (1018, "I Knew You Were Trouble"), (1018, "I Want You Back"), 
(1018, "I’m Still Standing"), (1018, "The Impression That I Get"), (1018, "Industry Baby"), (1018, "Land of 1000 Dances"), 
(1018, "Livin’ on a Prayer"), (1018, "Louie, Louie"), (1018, "My House"), (1018, "Never Going to Give You Up"), (1018, "Party in the U.S.A."), 
(1018, "Poker Face"), (1018, "Pompeii"), (1018, "Runaway Baby"), (1018, "September"), (1018, "Seven Nation Army"), (1018, "Shout It Out"), 
(1018, "Shut up and Dance"), (1018, "Some Nights"), (1018, "Starships"), (1018, "Sweet Caroline"), (1018, "Take On Me"), 
(1018, "Thnks Fr Th Mmrs"), (1018, "Trumpets"), (1018, "Uprising"), (1018, "Uptown Funk"), (1018, "Viva La Vida"), (1018, "White and Blue");
INSERT INTO folderSong VALUES 
(1019, "25 or 6 to 4"), (1019, "867-5309/Jenny"), (1019, "All the Small Things"), (1019, "Bad Romance"), (1019, "Blinding Lights"), 
(1019, "Build me up Buttercup"), (1019, "Carry on Wayward Son"), (1019, "Confident"), (1019, "Crazy Train"), (1019, "Dancing Queen"), 
(1019, "Don’t Stop Believin"), (1019, "Dynamite"), (1019, "Every time we touch"), (1019, "Fat Bottomed Girls"), (1019, "Final Countdown"), 
(1019, "Funky Town"), (1019, "Good 4 U"), (1019, "Handclap"), (1019, "Havana"), (1019, "Hey! Baby"), (1019, "Hey Song"), 
(1019, "High Hopes"), (1019, "High School Never Ends"), (1019, "Holiday"), (1019, "Hooked on a Feeling"), (1019, "How Far We’ve Come"), 
(1019, "I Knew You Were Trouble"), (1019, "I Want You Back"), (1019, "I’m Still Standing"), (1019, "The Impression That I Get"), 
(1019, "Industry Baby"), (1019, "Land of 1000 Dances"), (1019, "Livin’ on a Prayer"), (1019, "Louie, Louie"), (1019, "My House"), 
(1019, "Never Going to Give You Up"), (1019, "Party in the U.S.A."), (1019, "Poker Face"), (1019, "Pompeii"), (1019, "Runaway Baby"), 
(1019, "September"), (1019, "Seven Nation Army"), (1019, "Shout It Out"), (1019, "Shut up and Dance"), (1019, "Some Nights"), 
(1019, "Starships"), (1019, "Sweet Caroline"), (1019, "Take On Me"), (1019, "Thnks Fr Th Mmrs"), (1019, "Trumpets"), (1019, "Uprising"), 
(1019, "Uptown Funk"), (1019, "Viva La Vida"), (1019, "White and Blue");
INSERT INTO folderSong VALUES (1020, "25 or 6 to 4"), (1020, "867-5309/Jenny"), 
(1020, "All the Small Things"), (1020, "Bad Romance"), (1020, "Blinding Lights"), (1020, "Build me up Buttercup"), (1020, "Carry on Wayward Son"), 
(1020, "Confident"), (1020, "Crazy Train"), (1020, "Dancing Queen"), (1020, "Don’t Stop Believin"), (1020, "Dynamite"), 
(1020, "Every time we touch"), (1020, "Fat Bottomed Girls"), (1020, "Final Countdown"), (1020, "Funky Town"), (1020, "Good 4 U"), 
(1020, "Handclap"), (1020, "Havana"), (1020, "Hey! Baby"), (1020, "Hey Song"), (1020, "High Hopes"), (1020, "High School Never Ends"), 
(1020, "Holiday"), (1020, "Hooked on a Feeling"), (1020, "How Far We’ve Come"), (1020, "I Knew You Were Trouble"), (1020, "I Want You Back"), 
(1020, "I’m Still Standing"), (1020, "The Impression That I Get"), (1020, "Industry Baby"), (1020, "Land of 1000 Dances"), 
(1020, "Livin’ on a Prayer"), (1020, "Louie, Louie"), (1020, "My House"), (1020, "Never Going to Give You Up"), (1020, "Party in the U.S.A."), 
(1020, "Poker Face"), (1020, "Pompeii"), (1020, "Runaway Baby"), (1020, "September"), (1020, "Seven Nation Army"), (1020, "Shout It Out"), 
(1020, "Shut up and Dance"), (1020, "Some Nights"), (1020, "Starships"), (1020, "Sweet Caroline"), (1020, "Take On Me"), 
(1020, "Thnks Fr Th Mmrs"), (1020, "Trumpets"), (1020, "Uprising"), (1020, "Uptown Funk"), (1020, "Viva La Vida"), (1020, "White and Blue");
INSERT INTO folderSong VALUES 
(1021, "25 or 6 to 4"), (1021, "867-5309/Jenny"), (1021, "All the Small Things"), (1021, "Bad Romance"), (1021, "Blinding Lights"), 
(1021, "Build me up Buttercup"), (1021, "Carry on Wayward Son"), (1021, "Confident"), (1021, "Crazy Train"), (1021, "Dancing Queen"), 
(1021, "Don’t Stop Believin"), (1021, "Dynamite"), (1021, "Every time we touch"), (1021, "Fat Bottomed Girls"), (1021, "Final Countdown"), 
(1021, "Funky Town"), (1021, "Good 4 U"), (1021, "Handclap"), (1021, "Havana"), (1021, "Hey! Baby"), (1021, "Hey Song"), 
(1021, "High Hopes"), (1021, "High School Never Ends"), (1021, "Holiday"), (1021, "Hooked on a Feeling"), (1021, "How Far We’ve Come"), 
(1021, "I Knew You Were Trouble"), (1021, "I Want You Back"), (1021, "I’m Still Standing"), (1021, "The Impression That I Get"), 
(1021, "Industry Baby"), (1021, "Land of 1000 Dances"), (1021, "Livin’ on a Prayer"), (1021, "Louie, Louie"), (1021, "My House"), 
(1021, "Never Going to Give You Up"), (1021, "Party in the U.S.A."), (1021, "Poker Face"), (1021, "Pompeii"), (1021, "Runaway Baby"), 
(1021, "September"), (1021, "Seven Nation Army"), (1021, "Shout It Out"), (1021, "Shut up and Dance"), (1021, "Some Nights"), 
(1021, "Starships"), (1021, "Sweet Caroline"), (1021, "Take On Me"), (1021, "Thnks Fr Th Mmrs"), (1021, "Trumpets"), (1021, "Uprising"), 
(1021, "Uptown Funk"), (1021, "Viva La Vida"), (1021, "White and Blue");
INSERT INTO folderSong VALUES (1022, "25 or 6 to 4"), (1022, "867-5309/Jenny"), 
(1022, "All the Small Things"), (1022, "Bad Romance"), (1022, "Blinding Lights"), (1022, "Build me up Buttercup"), (1022, "Carry on Wayward Son"), 
(1022, "Confident"), (1022, "Crazy Train"), (1022, "Dancing Queen"), (1022, "Don’t Stop Believin"), (1022, "Dynamite"), 
(1022, "Every time we touch"), (1022, "Fat Bottomed Girls"), (1022, "Final Countdown"), (1022, "Funky Town"), (1022, "Good 4 U"), 
(1022, "Handclap"), (1022, "Havana"), (1022, "Hey! Baby"), (1022, "Hey Song"), (1022, "High Hopes"), (1022, "High School Never Ends"), 
(1022, "Holiday"), (1022, "Hooked on a Feeling"), (1022, "How Far We’ve Come"), (1022, "I Knew You Were Trouble"), (1022, "I Want You Back"), 
(1022, "I’m Still Standing"), (1022, "The Impression That I Get"), (1022, "Industry Baby"), (1022, "Land of 1000 Dances"), 
(1022, "Livin’ on a Prayer"), (1022, "Louie, Louie"), (1022, "My House"), (1022, "Never Going to Give You Up"), (1022, "Party in the U.S.A."), 
(1022, "Poker Face"), (1022, "Pompeii"), (1022, "Runaway Baby"), (1022, "September"), (1022, "Seven Nation Army"), (1022, "Shout It Out"), 
(1022, "Shut up and Dance"), (1022, "Some Nights"), (1022, "Starships"), (1022, "Sweet Caroline"), (1022, "Take On Me"), 
(1022, "Thnks Fr Th Mmrs"), (1022, "Trumpets"), (1022, "Uprising"), (1022, "Uptown Funk"), (1022, "Viva La Vida"), (1022, "White and Blue");
INSERT INTO folderSong VALUES 
(1023, "25 or 6 to 4"), (1023, "867-5309/Jenny"), (1023, "All the Small Things"), (1023, "Bad Romance"), (1023, "Blinding Lights"), 
(1023, "Build me up Buttercup"), (1023, "Carry on Wayward Son"), (1023, "Confident"), (1023, "Crazy Train"), (1023, "Dancing Queen"), 
(1023, "Don’t Stop Believin"), (1023, "Dynamite"), (1023, "Every time we touch"), (1023, "Fat Bottomed Girls"), (1023, "Final Countdown"), 
(1023, "Funky Town"), (1023, "Good 4 U"), (1023, "Handclap"), (1023, "Havana"), (1023, "Hey! Baby"), (1023, "Hey Song"), 
(1023, "High Hopes"), (1023, "High School Never Ends"), (1023, "Holiday"), (1023, "Hooked on a Feeling"), (1023, "How Far We’ve Come"), 
(1023, "I Knew You Were Trouble"), (1023, "I Want You Back"), (1023, "I’m Still Standing"), (1023, "The Impression That I Get"), 
(1023, "Industry Baby"), (1023, "Land of 1000 Dances"), (1023, "Livin’ on a Prayer"), (1023, "Louie, Louie"), (1023, "My House"), 
(1023, "Never Going to Give You Up"), (1023, "Party in the U.S.A."), (1023, "Poker Face"), (1023, "Pompeii"), (1023, "Runaway Baby"), 
(1023, "September"), (1023, "Seven Nation Army"), (1023, "Shout It Out"), (1023, "Shut up and Dance"), (1023, "Some Nights"), 
(1023, "Starships"), (1023, "Sweet Caroline"), (1023, "Take On Me"), (1023, "Thnks Fr Th Mmrs"), (1023, "Trumpets"), (1023, "Uprising"), 
(1023, "Uptown Funk"), (1023, "Viva La Vida"), (1023, "White and Blue");
INSERT INTO folderSong VALUES (1024, "25 or 6 to 4"), (1024, "867-5309/Jenny"), 
(1024, "All the Small Things"), (1024, "Bad Romance"), (1024, "Blinding Lights"), (1024, "Build me up Buttercup"), (1024, "Carry on Wayward Son"), 
(1024, "Confident"), (1024, "Crazy Train"), (1024, "Dancing Queen"), (1024, "Don’t Stop Believin"), (1024, "Dynamite"), 
(1024, "Every time we touch"), (1024, "Fat Bottomed Girls"), (1024, "Final Countdown"), (1024, "Funky Town"), (1024, "Good 4 U"), 
(1024, "Handclap"), (1024, "Havana"), (1024, "Hey! Baby"), (1024, "Hey Song"), (1024, "High Hopes"), (1024, "High School Never Ends"), 
(1024, "Holiday"), (1024, "Hooked on a Feeling"), (1024, "How Far We’ve Come"), (1024, "I Knew You Were Trouble"), (1024, "I Want You Back"), 
(1024, "I’m Still Standing"), (1024, "The Impression That I Get"), (1024, "Industry Baby"), (1024, "Land of 1000 Dances"), 
(1024, "Livin’ on a Prayer"), (1024, "Louie, Louie"), (1024, "My House"), (1024, "Never Going to Give You Up"), (1024, "Party in the U.S.A."), 
(1024, "Poker Face"), (1024, "Pompeii"), (1024, "Runaway Baby"), (1024, "September"), (1024, "Seven Nation Army"), (1024, "Shout It Out"), 
(1024, "Shut up and Dance"), (1024, "Some Nights"), (1024, "Starships"), (1024, "Sweet Caroline"), (1024, "Take On Me"), 
(1024, "Thnks Fr Th Mmrs"), (1024, "Trumpets"), (1024, "Uprising"), (1024, "Uptown Funk"), (1024, "Viva La Vida"), (1024, "White and Blue");
INSERT INTO folderSong VALUES 
(1025, "25 or 6 to 4"), (1025, "867-5309/Jenny"), (1025, "All the Small Things"), (1025, "Bad Romance"), (1025, "Blinding Lights"), 
(1025, "Build me up Buttercup"), (1025, "Carry on Wayward Son"), (1025, "Confident"), (1025, "Crazy Train"), (1025, "Dancing Queen"), 
(1025, "Don’t Stop Believin"), (1025, "Dynamite"), (1025, "Every time we touch"), (1025, "Fat Bottomed Girls"), (1025, "Final Countdown"), 
(1025, "Funky Town"), (1025, "Good 4 U"), (1025, "Handclap"), (1025, "Havana"), (1025, "Hey! Baby"), (1025, "Hey Song"), 
(1025, "High Hopes"), (1025, "High School Never Ends"), (1025, "Holiday"), (1025, "Hooked on a Feeling"), (1025, "How Far We’ve Come"), 
(1025, "I Knew You Were Trouble"), (1025, "I Want You Back"), (1025, "I’m Still Standing"), (1025, "The Impression That I Get"), 
(1025, "Industry Baby"), (1025, "Land of 1000 Dances"), (1025, "Livin’ on a Prayer"), (1025, "Louie, Louie"), (1025, "My House"), 
(1025, "Never Going to Give You Up"), (1025, "Party in the U.S.A."), (1025, "Poker Face"), (1025, "Pompeii"), (1025, "Runaway Baby"), 
(1025, "September"), (1025, "Seven Nation Army"), (1025, "Shout It Out"), (1025, "Shut up and Dance"), (1025, "Some Nights"), 
(1025, "Starships"), (1025, "Sweet Caroline"), (1025, "Take On Me"), (1025, "Thnks Fr Th Mmrs"), (1025, "Trumpets"), (1025, "Uprising"), 
(1025, "Uptown Funk"), (1025, "Viva La Vida"), (1025, "White and Blue");
INSERT INTO folderSong VALUES (1026, "25 or 6 to 4"), (1026, "867-5309/Jenny"), 
(1026, "All the Small Things"), (1026, "Bad Romance"), (1026, "Blinding Lights"), (1026, "Build me up Buttercup"), (1026, "Carry on Wayward Son"), 
(1026, "Confident"), (1026, "Crazy Train"), (1026, "Dancing Queen"), (1026, "Don’t Stop Believin"), (1026, "Dynamite"), 
(1026, "Every time we touch"), (1026, "Fat Bottomed Girls"), (1026, "Final Countdown"), (1026, "Funky Town"), (1026, "Good 4 U"), 
(1026, "Handclap"), (1026, "Havana"), (1026, "Hey! Baby"), (1026, "Hey Song"), (1026, "High Hopes"), (1026, "High School Never Ends"), 
(1026, "Holiday"), (1026, "Hooked on a Feeling"), (1026, "How Far We’ve Come"), (1026, "I Knew You Were Trouble"), (1026, "I Want You Back"), 
(1026, "I’m Still Standing"), (1026, "The Impression That I Get"), (1026, "Industry Baby"), (1026, "Land of 1000 Dances"), 
(1026, "Livin’ on a Prayer"), (1026, "Louie, Louie"), (1026, "My House"), (1026, "Never Going to Give You Up"), (1026, "Party in the U.S.A."), 
(1026, "Poker Face"), (1026, "Pompeii"), (1026, "Runaway Baby"), (1026, "September"), (1026, "Seven Nation Army"), (1026, "Shout It Out"), 
(1026, "Shut up and Dance"), (1026, "Some Nights"), (1026, "Starships"), (1026, "Sweet Caroline"), (1026, "Take On Me"), 
(1026, "Thnks Fr Th Mmrs"), (1026, "Trumpets"), (1026, "Uprising"), (1026, "Uptown Funk"), (1026, "Viva La Vida"), (1026, "White and Blue");
INSERT INTO folderSong VALUES 
(1027, "25 or 6 to 4"), (1027, "867-5309/Jenny"), (1027, "All the Small Things"), (1027, "Bad Romance"), (1027, "Blinding Lights"), 
(1027, "Build me up Buttercup"), (1027, "Carry on Wayward Son"), (1027, "Confident"), (1027, "Crazy Train"), (1027, "Dancing Queen"), 
(1027, "Don’t Stop Believin"), (1027, "Dynamite"), (1027, "Every time we touch"), (1027, "Fat Bottomed Girls"), (1027, "Final Countdown"), 
(1027, "Funky Town"), (1027, "Good 4 U"), (1027, "Handclap"), (1027, "Havana"), (1027, "Hey! Baby"), (1027, "Hey Song"), 
(1027, "High Hopes"), (1027, "High School Never Ends"), (1027, "Holiday"), (1027, "Hooked on a Feeling"), (1027, "How Far We’ve Come"), 
(1027, "I Knew You Were Trouble"), (1027, "I Want You Back"), (1027, "I’m Still Standing"), (1027, "The Impression That I Get"), 
(1027, "Industry Baby"), (1027, "Land of 1000 Dances"), (1027, "Livin’ on a Prayer"), (1027, "Louie, Louie"), (1027, "My House"), 
(1027, "Never Going to Give You Up"), (1027, "Party in the U.S.A."), (1027, "Poker Face"), (1027, "Pompeii"), (1027, "Runaway Baby"), 
(1027, "September"), (1027, "Seven Nation Army"), (1027, "Shout It Out"), (1027, "Shut up and Dance"), (1027, "Some Nights"), 
(1027, "Starships"), (1027, "Sweet Caroline"), (1027, "Take On Me"), (1027, "Thnks Fr Th Mmrs"), (1027, "Trumpets"), (1027, "Uprising"), 
(1027, "Uptown Funk"), (1027, "Viva La Vida"), (1027, "White and Blue");
INSERT INTO folderSong VALUES (1028, "25 or 6 to 4"), (1028, "867-5309/Jenny"), 
(1028, "All the Small Things"), (1028, "Bad Romance"), (1028, "Blinding Lights"), (1028, "Build me up Buttercup"), (1028, "Carry on Wayward Son"), 
(1028, "Confident"), (1028, "Crazy Train"), (1028, "Dancing Queen"), (1028, "Don’t Stop Believin"), (1028, "Dynamite"), 
(1028, "Every time we touch"), (1028, "Fat Bottomed Girls"), (1028, "Final Countdown"), (1028, "Funky Town"), (1028, "Good 4 U"), 
(1028, "Handclap"), (1028, "Havana"), (1028, "Hey! Baby"), (1028, "Hey Song"), (1028, "High Hopes"), (1028, "High School Never Ends"), 
(1028, "Holiday"), (1028, "Hooked on a Feeling"), (1028, "How Far We’ve Come"), (1028, "I Knew You Were Trouble"), (1028, "I Want You Back"), 
(1028, "I’m Still Standing"), (1028, "The Impression That I Get"), (1028, "Industry Baby"), (1028, "Land of 1000 Dances"), 
(1028, "Livin’ on a Prayer"), (1028, "Louie, Louie"), (1028, "My House"), (1028, "Never Going to Give You Up"), (1028, "Party in the U.S.A."), 
(1028, "Poker Face"), (1028, "Pompeii"), (1028, "Runaway Baby"), (1028, "September"), (1028, "Seven Nation Army"), (1028, "Shout It Out"), 
(1028, "Shut up and Dance"), (1028, "Some Nights"), (1028, "Starships"), (1028, "Sweet Caroline"), (1028, "Take On Me"), 
(1028, "Thnks Fr Th Mmrs"), (1028, "Trumpets"), (1028, "Uprising"), (1028, "Uptown Funk"), (1028, "Viva La Vida"), (1028, "White and Blue");
INSERT INTO folderSong VALUES 
(1029, "25 or 6 to 4"), (1029, "867-5309/Jenny"), (1029, "All the Small Things"), (1029, "Bad Romance"), (1029, "Blinding Lights"), 
(1029, "Build me up Buttercup"), (1029, "Carry on Wayward Son"), (1029, "Confident"), (1029, "Crazy Train"), (1029, "Dancing Queen"), 
(1029, "Don’t Stop Believin"), (1029, "Dynamite"), (1029, "Every time we touch"), (1029, "Fat Bottomed Girls"), (1029, "Final Countdown"), 
(1029, "Funky Town"), (1029, "Good 4 U"), (1029, "Handclap"), (1029, "Havana"), (1029, "Hey! Baby"), (1029, "Hey Song"), 
(1029, "High Hopes"), (1029, "High School Never Ends"), (1029, "Holiday"), (1029, "Hooked on a Feeling"), (1029, "How Far We’ve Come"), 
(1029, "I Knew You Were Trouble"), (1029, "I Want You Back"), (1029, "I’m Still Standing"), (1029, "The Impression That I Get"), 
(1029, "Industry Baby"), (1029, "Land of 1000 Dances"), (1029, "Livin’ on a Prayer"), (1029, "Louie, Louie"), (1029, "My House"), 
(1029, "Never Going to Give You Up"), (1029, "Party in the U.S.A."), (1029, "Poker Face"), (1029, "Pompeii"), (1029, "Runaway Baby"), 
(1029, "September"), (1029, "Seven Nation Army"), (1029, "Shout It Out"), (1029, "Shut up and Dance"), (1029, "Some Nights"), 
(1029, "Starships"), (1029, "Sweet Caroline"), (1029, "Take On Me"), (1029, "Thnks Fr Th Mmrs"), (1029, "Trumpets"), (1029, "Uprising"), 
(1029, "Uptown Funk"), (1029, "Viva La Vida"), (1029, "White and Blue");
INSERT INTO folderSong VALUES (1030, "25 or 6 to 4"), (1030, "867-5309/Jenny"), 
(1030, "All the Small Things"), (1030, "Bad Romance"), (1030, "Blinding Lights"), (1030, "Build me up Buttercup"), (1030, "Carry on Wayward Son"), 
(1030, "Confident"), (1030, "Crazy Train"), (1030, "Dancing Queen"), (1030, "Don’t Stop Believin"), (1030, "Dynamite"), 
(1030, "Every time we touch"), (1030, "Fat Bottomed Girls"), (1030, "Final Countdown"), (1030, "Funky Town"), (1030, "Good 4 U"), 
(1030, "Handclap"), (1030, "Havana"), (1030, "Hey! Baby"), (1030, "Hey Song"), (1030, "High Hopes"), (1030, "High School Never Ends"), 
(1030, "Holiday"), (1030, "Hooked on a Feeling"), (1030, "How Far We’ve Come"), (1030, "I Knew You Were Trouble"), (1030, "I Want You Back"), 
(1030, "I’m Still Standing"), (1030, "The Impression That I Get"), (1030, "Industry Baby"), (1030, "Land of 1000 Dances"), 
(1030, "Livin’ on a Prayer"), (1030, "Louie, Louie"), (1030, "My House"), (1030, "Never Going to Give You Up"), (1030, "Party in the U.S.A."), 
(1030, "Poker Face"), (1030, "Pompeii"), (1030, "Runaway Baby"), (1030, "September"), (1030, "Seven Nation Army"), (1030, "Shout It Out"), 
(1030, "Shut up and Dance"), (1030, "Some Nights"), (1030, "Starships"), (1030, "Sweet Caroline"), (1030, "Take On Me"), 
(1030, "Thnks Fr Th Mmrs"), (1030, "Trumpets"), (1030, "Uprising"), (1030, "Uptown Funk"), (1030, "Viva La Vida"), (1030, "White and Blue");
INSERT INTO folderSong VALUES 
(1031, "25 or 6 to 4"), (1031, "867-5309/Jenny"), (1031, "All the Small Things"), (1031, "Bad Romance"), (1031, "Blinding Lights"), 
(1031, "Build me up Buttercup"), (1031, "Carry on Wayward Son"), (1031, "Confident"), (1031, "Crazy Train"), (1031, "Dancing Queen"), 
(1031, "Don’t Stop Believin"), (1031, "Dynamite"), (1031, "Every time we touch"), (1031, "Fat Bottomed Girls"), (1031, "Final Countdown"), 
(1031, "Funky Town"), (1031, "Good 4 U"), (1031, "Handclap"), (1031, "Havana"), (1031, "Hey! Baby"), (1031, "Hey Song"), 
(1031, "High Hopes"), (1031, "High School Never Ends"), (1031, "Holiday"), (1031, "Hooked on a Feeling"), (1031, "How Far We’ve Come"), 
(1031, "I Knew You Were Trouble"), (1031, "I Want You Back"), (1031, "I’m Still Standing"), (1031, "The Impression That I Get"), 
(1031, "Industry Baby"), (1031, "Land of 1000 Dances"), (1031, "Livin’ on a Prayer"), (1031, "Louie, Louie"), (1031, "My House"), 
(1031, "Never Going to Give You Up"), (1031, "Party in the U.S.A."), (1031, "Poker Face"), (1031, "Pompeii"), (1031, "Runaway Baby"), 
(1031, "September"), (1031, "Seven Nation Army"), (1031, "Shout It Out"), (1031, "Shut up and Dance"), (1031, "Some Nights"), 
(1031, "Starships"), (1031, "Sweet Caroline"), (1031, "Take On Me"), (1031, "Thnks Fr Th Mmrs"), (1031, "Trumpets"), (1031, "Uprising"), 
(1031, "Uptown Funk"), (1031, "Viva La Vida"), (1031, "White and Blue");
INSERT INTO folderSong VALUES (1032, "25 or 6 to 4"), (1032, "867-5309/Jenny"), 
(1032, "All the Small Things"), (1032, "Bad Romance"), (1032, "Blinding Lights"), (1032, "Build me up Buttercup"), (1032, "Carry on Wayward Son"), 
(1032, "Confident"), (1032, "Crazy Train"), (1032, "Dancing Queen"), (1032, "Don’t Stop Believin"), (1032, "Dynamite"), 
(1032, "Every time we touch"), (1032, "Fat Bottomed Girls"), (1032, "Final Countdown"), (1032, "Funky Town"), (1032, "Good 4 U"), 
(1032, "Handclap"), (1032, "Havana"), (1032, "Hey! Baby"), (1032, "Hey Song"), (1032, "High Hopes"), (1032, "High School Never Ends"), 
(1032, "Holiday"), (1032, "Hooked on a Feeling"), (1032, "How Far We’ve Come"), (1032, "I Knew You Were Trouble"), (1032, "I Want You Back"), 
(1032, "I’m Still Standing"), (1032, "The Impression That I Get"), (1032, "Industry Baby"), (1032, "Land of 1000 Dances"), 
(1032, "Livin’ on a Prayer"), (1032, "Louie, Louie"), (1032, "My House"), (1032, "Never Going to Give You Up"), (1032, "Party in the U.S.A."), 
(1032, "Poker Face"), (1032, "Pompeii"), (1032, "Runaway Baby"), (1032, "September"), (1032, "Seven Nation Army"), (1032, "Shout It Out"), 
(1032, "Shut up and Dance"), (1032, "Some Nights"), (1032, "Starships"), (1032, "Sweet Caroline"), (1032, "Take On Me"), 
(1032, "Thnks Fr Th Mmrs"), (1032, "Trumpets"), (1032, "Uprising"), (1032, "Uptown Funk"), (1032, "Viva La Vida"), (1032, "White and Blue");
INSERT INTO folderSong VALUES 
(1033, "25 or 6 to 4"), (1033, "867-5309/Jenny"), (1033, "All the Small Things"), (1033, "Bad Romance"), (1033, "Blinding Lights"), 
(1033, "Build me up Buttercup"), (1033, "Carry on Wayward Son"), (1033, "Confident"), (1033, "Crazy Train"), (1033, "Dancing Queen"), 
(1033, "Don’t Stop Believin"), (1033, "Dynamite"), (1033, "Every time we touch"), (1033, "Fat Bottomed Girls"), (1033, "Final Countdown"), 
(1033, "Funky Town"), (1033, "Good 4 U"), (1033, "Handclap"), (1033, "Havana"), (1033, "Hey! Baby"), (1033, "Hey Song"), 
(1033, "High Hopes"), (1033, "High School Never Ends"), (1033, "Holiday"), (1033, "Hooked on a Feeling"), (1033, "How Far We’ve Come"), 
(1033, "I Knew You Were Trouble"), (1033, "I Want You Back"), (1033, "I’m Still Standing"), (1033, "The Impression That I Get"), 
(1033, "Industry Baby"), (1033, "Land of 1000 Dances"), (1033, "Livin’ on a Prayer"), (1033, "Louie, Louie"), (1033, "My House"), 
(1033, "Never Going to Give You Up"), (1033, "Party in the U.S.A."), (1033, "Poker Face"), (1033, "Pompeii"), (1033, "Runaway Baby"), 
(1033, "September"), (1033, "Seven Nation Army"), (1033, "Shout It Out"), (1033, "Shut up and Dance"), (1033, "Some Nights"), 
(1033, "Starships"), (1033, "Sweet Caroline"), (1033, "Take On Me"), (1033, "Thnks Fr Th Mmrs"), (1033, "Trumpets"), (1033, "Uprising"), 
(1033, "Uptown Funk"), (1033, "Viva La Vida"), (1033, "White and Blue");
INSERT INTO folderSong VALUES (1034, "25 or 6 to 4"), (1034, "867-5309/Jenny"), 
(1034, "All the Small Things"), (1034, "Bad Romance"), (1034, "Blinding Lights"), (1034, "Build me up Buttercup"), (1034, "Carry on Wayward Son"), 
(1034, "Confident"), (1034, "Crazy Train"), (1034, "Dancing Queen"), (1034, "Don’t Stop Believin"), (1034, "Dynamite"), 
(1034, "Every time we touch"), (1034, "Fat Bottomed Girls"), (1034, "Final Countdown"), (1034, "Funky Town"), (1034, "Good 4 U"), 
(1034, "Handclap"), (1034, "Havana"), (1034, "Hey! Baby"), (1034, "Hey Song"), (1034, "High Hopes"), (1034, "High School Never Ends"), 
(1034, "Holiday"), (1034, "Hooked on a Feeling"), (1034, "How Far We’ve Come"), (1034, "I Knew You Were Trouble"), (1034, "I Want You Back"), 
(1034, "I’m Still Standing"), (1034, "The Impression That I Get"), (1034, "Industry Baby"), (1034, "Land of 1000 Dances"), 
(1034, "Livin’ on a Prayer"), (1034, "Louie, Louie"), (1034, "My House"), (1034, "Never Going to Give You Up"), (1034, "Party in the U.S.A."), 
(1034, "Poker Face"), (1034, "Pompeii"), (1034, "Runaway Baby"), (1034, "September"), (1034, "Seven Nation Army"), (1034, "Shout It Out"), 
(1034, "Shut up and Dance"), (1034, "Some Nights"), (1034, "Starships"), (1034, "Sweet Caroline"), (1034, "Take On Me"), 
(1034, "Thnks Fr Th Mmrs"), (1034, "Trumpets"), (1034, "Uprising"), (1034, "Uptown Funk"), (1034, "Viva La Vida"), (1034, "White and Blue");
INSERT INTO folderSong VALUES 
(1035, "25 or 6 to 4"), (1035, "867-5309/Jenny"), (1035, "All the Small Things"), (1035, "Bad Romance"), (1035, "Blinding Lights"), 
(1035, "Build me up Buttercup"), (1035, "Carry on Wayward Son"), (1035, "Confident"), (1035, "Crazy Train"), (1035, "Dancing Queen"), 
(1035, "Don’t Stop Believin"), (1035, "Dynamite"), (1035, "Every time we touch"), (1035, "Fat Bottomed Girls"), (1035, "Final Countdown"), 
(1035, "Funky Town"), (1035, "Good 4 U"), (1035, "Handclap"), (1035, "Havana"), (1035, "Hey! Baby"), (1035, "Hey Song"), 
(1035, "High Hopes"), (1035, "High School Never Ends"), (1035, "Holiday"), (1035, "Hooked on a Feeling"), (1035, "How Far We’ve Come"), 
(1035, "I Knew You Were Trouble"), (1035, "I Want You Back"), (1035, "I’m Still Standing"), (1035, "The Impression That I Get"), 
(1035, "Industry Baby"), (1035, "Land of 1000 Dances"), (1035, "Livin’ on a Prayer"), (1035, "Louie, Louie"), (1035, "My House"), 
(1035, "Never Going to Give You Up"), (1035, "Party in the U.S.A."), (1035, "Poker Face"), (1035, "Pompeii"), (1035, "Runaway Baby"), 
(1035, "September"), (1035, "Seven Nation Army"), (1035, "Shout It Out"), (1035, "Shut up and Dance"), (1035, "Some Nights"), 
(1035, "Starships"), (1035, "Sweet Caroline"), (1035, "Take On Me"), (1035, "Thnks Fr Th Mmrs"), (1035, "Trumpets"), (1035, "Uprising"), 
(1035, "Uptown Funk"), (1035, "Viva La Vida"), (1035, "White and Blue");
INSERT INTO folderSong VALUES (1036, "25 or 6 to 4"), (1036, "867-5309/Jenny"), 
(1036, "All the Small Things"), (1036, "Bad Romance"), (1036, "Blinding Lights"), (1036, "Build me up Buttercup"), (1036, "Carry on Wayward Son"), 
(1036, "Confident"), (1036, "Crazy Train"), (1036, "Dancing Queen"), (1036, "Don’t Stop Believin"), (1036, "Dynamite"), 
(1036, "Every time we touch"), (1036, "Fat Bottomed Girls"), (1036, "Final Countdown"), (1036, "Funky Town"), (1036, "Good 4 U"), 
(1036, "Handclap"), (1036, "Havana"), (1036, "Hey! Baby"), (1036, "Hey Song"), (1036, "High Hopes"), (1036, "High School Never Ends"), 
(1036, "Holiday"), (1036, "Hooked on a Feeling"), (1036, "How Far We’ve Come"), (1036, "I Knew You Were Trouble"), (1036, "I Want You Back"), 
(1036, "I’m Still Standing"), (1036, "The Impression That I Get"), (1036, "Industry Baby"), (1036, "Land of 1000 Dances"), 
(1036, "Livin’ on a Prayer"), (1036, "Louie, Louie"), (1036, "My House"), (1036, "Never Going to Give You Up"), (1036, "Party in the U.S.A."), 
(1036, "Poker Face"), (1036, "Pompeii"), (1036, "Runaway Baby"), (1036, "September"), (1036, "Seven Nation Army"), (1036, "Shout It Out"), 
(1036, "Shut up and Dance"), (1036, "Some Nights"), (1036, "Starships"), (1036, "Sweet Caroline"), (1036, "Take On Me"), 
(1036, "Thnks Fr Th Mmrs"), (1036, "Trumpets"), (1036, "Uprising"), (1036, "Uptown Funk"), (1036, "Viva La Vida"), (1036, "White and Blue");
INSERT INTO folderSong VALUES 
(1037, "25 or 6 to 4"), (1037, "867-5309/Jenny"), (1037, "All the Small Things"), (1037, "Bad Romance"), (1037, "Blinding Lights"), 
(1037, "Build me up Buttercup"), (1037, "Carry on Wayward Son"), (1037, "Confident"), (1037, "Crazy Train"), (1037, "Dancing Queen"), 
(1037, "Don’t Stop Believin"), (1037, "Dynamite"), (1037, "Every time we touch"), (1037, "Fat Bottomed Girls"), (1037, "Final Countdown"), 
(1037, "Funky Town"), (1037, "Good 4 U"), (1037, "Handclap"), (1037, "Havana"), (1037, "Hey! Baby"), (1037, "Hey Song"), 
(1037, "High Hopes"), (1037, "High School Never Ends"), (1037, "Holiday"), (1037, "Hooked on a Feeling"), (1037, "How Far We’ve Come"), 
(1037, "I Knew You Were Trouble"), (1037, "I Want You Back"), (1037, "I’m Still Standing"), (1037, "The Impression That I Get"), 
(1037, "Industry Baby"), (1037, "Land of 1000 Dances"), (1037, "Livin’ on a Prayer"), (1037, "Louie, Louie"), (1037, "My House"), 
(1037, "Never Going to Give You Up"), (1037, "Party in the U.S.A."), (1037, "Poker Face"), (1037, "Pompeii"), (1037, "Runaway Baby"), 
(1037, "September"), (1037, "Seven Nation Army"), (1037, "Shout It Out"), (1037, "Shut up and Dance"), (1037, "Some Nights"), 
(1037, "Starships"), (1037, "Sweet Caroline"), (1037, "Take On Me"), (1037, "Thnks Fr Th Mmrs"), (1037, "Trumpets"), (1037, "Uprising"), 
(1037, "Uptown Funk"), (1037, "Viva La Vida"), (1037, "White and Blue");
INSERT INTO folderSong VALUES (1038, "25 or 6 to 4"), (1038, "867-5309/Jenny"), 
(1038, "All the Small Things"), (1038, "Bad Romance"), (1038, "Blinding Lights"), (1038, "Build me up Buttercup"), (1038, "Carry on Wayward Son"), 
(1038, "Confident"), (1038, "Crazy Train"), (1038, "Dancing Queen"), (1038, "Don’t Stop Believin"), (1038, "Dynamite"), 
(1038, "Every time we touch"), (1038, "Fat Bottomed Girls"), (1038, "Final Countdown"), (1038, "Funky Town"), (1038, "Good 4 U"), 
(1038, "Handclap"), (1038, "Havana"), (1038, "Hey! Baby"), (1038, "Hey Song"), (1038, "High Hopes"), (1038, "High School Never Ends"), 
(1038, "Holiday"), (1038, "Hooked on a Feeling"), (1038, "How Far We’ve Come"), (1038, "I Knew You Were Trouble"), (1038, "I Want You Back"), 
(1038, "I’m Still Standing"), (1038, "The Impression That I Get"), (1038, "Industry Baby"), (1038, "Land of 1000 Dances"), 
(1038, "Livin’ on a Prayer"), (1038, "Louie, Louie"), (1038, "My House"), (1038, "Never Going to Give You Up"), (1038, "Party in the U.S.A."), 
(1038, "Poker Face"), (1038, "Pompeii"), (1038, "Runaway Baby"), (1038, "September"), (1038, "Seven Nation Army"), (1038, "Shout It Out"), 
(1038, "Shut up and Dance"), (1038, "Some Nights"), (1038, "Starships"), (1038, "Sweet Caroline"), (1038, "Take On Me"), 
(1038, "Thnks Fr Th Mmrs"), (1038, "Trumpets"), (1038, "Uprising"), (1038, "Uptown Funk"), (1038, "Viva La Vida"), (1038, "White and Blue"); 
INSERT INTO folderSong VALUES 
(1039, "25 or 6 to 4"), (1039, "867-5309/Jenny"), (1039, "All the Small Things"), (1039, "Bad Romance"), (1039, "Blinding Lights"), 
(1039, "Build me up Buttercup"), (1039, "Carry on Wayward Son"), (1039, "Confident"), (1039, "Crazy Train"), (1039, "Dancing Queen"), 
(1039, "Don’t Stop Believin"), (1039, "Dynamite"), (1039, "Every time we touch"), (1039, "Fat Bottomed Girls"), (1039, "Final Countdown"), 
(1039, "Funky Town"), (1039, "Good 4 U"), (1039, "Handclap"), (1039, "Havana"), (1039, "Hey! Baby"), (1039, "Hey Song"), 
(1039, "High Hopes"), (1039, "High School Never Ends"), (1039, "Holiday"), (1039, "Hooked on a Feeling"), (1039, "How Far We’ve Come"), 
(1039, "I Knew You Were Trouble"), (1039, "I Want You Back"), (1039, "I’m Still Standing"), (1039, "The Impression That I Get"), 
(1039, "Industry Baby"), (1039, "Land of 1000 Dances"), (1039, "Livin’ on a Prayer"), (1039, "Louie, Louie"), (1039, "My House"), 
(1039, "Never Going to Give You Up"), (1039, "Party in the U.S.A."), (1039, "Poker Face"), (1039, "Pompeii"), (1039, "Runaway Baby"), 
(1039, "September"), (1039, "Seven Nation Army"), (1039, "Shout It Out"), (1039, "Shut up and Dance"), (1039, "Some Nights"), 
(1039, "Starships"), (1039, "Sweet Caroline"), (1039, "Take On Me"), (1039, "Thnks Fr Th Mmrs"), (1039, "Trumpets"), (1039, "Uprising"), 
(1039, "Uptown Funk"), (1039, "Viva La Vida"), (1039, "White and Blue");
INSERT INTO folderSong VALUES (1040, "25 or 6 to 4"), (1040, "867-5309/Jenny"), 
(1040, "All the Small Things"), (1040, "Bad Romance"), (1040, "Blinding Lights"), (1040, "Build me up Buttercup"), (1040, "Carry on Wayward Son"), 
(1040, "Confident"), (1040, "Crazy Train"), (1040, "Dancing Queen"), (1040, "Don’t Stop Believin"), (1040, "Dynamite"), 
(1040, "Every time we touch"), (1040, "Fat Bottomed Girls"), (1040, "Final Countdown"), (1040, "Funky Town"), (1040, "Good 4 U"), 
(1040, "Handclap"), (1040, "Havana"), (1040, "Hey! Baby"), (1040, "Hey Song"), (1040, "High Hopes"), (1040, "High School Never Ends"), 
(1040, "Holiday"), (1040, "Hooked on a Feeling"), (1040, "How Far We’ve Come"), (1040, "I Knew You Were Trouble"), (1040, "I Want You Back"), 
(1040, "I’m Still Standing"), (1040, "The Impression That I Get"), (1040, "Industry Baby"), (1040, "Land of 1000 Dances"), 
(1040, "Livin’ on a Prayer"), (1040, "Louie, Louie"), (1040, "My House"), (1040, "Never Going to Give You Up"), (1040, "Party in the U.S.A."), 
(1040, "Poker Face"), (1040, "Pompeii"), (1040, "Runaway Baby"), (1040, "September"), (1040, "Seven Nation Army"), (1040, "Shout It Out"), 
(1040, "Shut up and Dance"), (1040, "Some Nights"), (1040, "Starships"), (1040, "Sweet Caroline"), (1040, "Take On Me"), 
(1040, "Thnks Fr Th Mmrs"), (1040, "Trumpets"), (1040, "Uprising"), (1040, "Uptown Funk"), (1040, "Viva La Vida"), (1040, "White and Blue");

DROP TABLE IF EXISTS tags;
CREATE TABLE tags (
	song_title VARCHAR(255) NOT NULL,
    tag_type VARCHAR(255) NOT NULL,
    PRIMARY KEY (song_title, tag_type),
    CONSTRAINT tags_ibfk_1 FOREIGN KEY(song_title) REFERENCES song(song_title)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE utf8mb4_unicode_ci;

-- INSERT VALUES FOR TAGS
INSERT INTO tags VALUES ("25 or 6 to 4", "optional repeat"), ("867-5309/Jenny", "none"), ("All the Small Things", "none"), ("Bad Romance", "none"), 
	("Blinding Lights", "second ending"), ("Build me up Buttercup", "optional ending"), ("Carry on Wayward Son", "optional repeat"), 
	("Confident", "none"), ("Crazy Train", "second ending"), ("Dancing Queen", "none");
INSERT INTO tags VALUES ("Don’t Stop Believin", "optional ending"), 
	("Dynamite", "optional ending"), ("Every time we touch", "none"), ("Fat Bottomed Girls", "optional ending"), ("Final Countdown", "none"), 
	("Funky Town", "optional ending"), ("Good 4 U", "none"), ("Handclap", "second ending"), ("Havana", "optional ending"), ("Hey! Baby", "none");
INSERT INTO tags VALUES ("High Hopes", "none"), ("High School Never Ends", "second ending"), ("Holiday", "none"), 
	("Hooked on a Feeling", "none"), ("How Far We’ve Come", "none"), ("I Knew You Were Trouble", "none"), ("I Want You Back", "optional ending"), 
	("I’m Still Standing", "none"), ("The Impression That I Get", "none"), ("Industry Baby", "optional ending"), ("Land of 1000 Dances", "second ending");
INSERT INTO tags VALUES ("Livin’ on a Prayer", "second ending"), ("Louie, Louie", "optional ending"), ("My House", "optional ending"), ("Never Going to Give You Up", "optional ending"), 
	("Party in the U.S.A.", "optional ending"), ("Poker Face", "second ending"), ("Pompeii", "second ending"), ("Runaway Baby", "second ending"), 
	("September", "none"), ("Seven Nation Army", "none"), ("Shout It Out", "optional repeat");
INSERT INTO tags VALUES ("Shut up and Dance", "none"), 
	("Some Nights", "none"), ("Starships", "optional ending"), ("Sweet Caroline", "optional ending"), ("Take On Me", "none"), 
	("Thnks Fr Th Mmrs", "optional repeat"), ("Trumpets", "none"), ("Uprising", "optional repeat"), ("Uptown Funk", "none"), 
	("Viva La Vida", "second ending"), ("White and Blue", "second ending");