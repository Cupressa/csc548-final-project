import streamlit as st
from sqlalchemy.sql import text

netIDs = ["jcl87216", "kkt69480", "kqu36181"]
try:
    if st.session_state['authentication_status']:
        if st.session_state["roles"][0] in ["USER", "EXECUTIVE", "ADMINISTRATOR"]:
            conn = st.connection(
                "sql",
                dialect="mysql",
                host="localhost",
                database = "csc548band",
                username = "pep_user",
                password = "userProfile",
            )
            st.title("Make a folder or song request")
            requestType = st.radio(
                "Select request type",
                ["folder", "song"]
            )
            if(requestType == "folder"):

                sectionDF = conn.query("SELECT DISTINCT section FROM members ORDER BY section;", ttl=600)
                section = st.selectbox(
                    "Select a section", [f"{row.section}" for row in sectionDF.itertuples()]
                )
                if(st.button("Submit selection")):
                    with conn.session as session:
                        session.execute(text(f"INSERT requests VALUES (DEFAULT, {netIDs.index(st.session_state['username'])+1}, NOW(), FALSE);"))
                        session.execute(text(f"INSERT folder_requests VALUES((SELECT MAX(requestId) FROM requests), {section});"))
                        session.commit()
            else:
                songDF = conn.query('SELECT song_title FROM song;', ttl=600)
                song = st.selectbox(
                    "Select a song", [f"{row.song_title}" for row in songDF.itertuples()]
                )
                if(st.button("Submit selection")):
                    with conn.session as session:
                        session.execute(text(f"INSERT requests VALUES (DEFAULT, {netIDs.index(st.session_state['username'])+1}, NOW(), FALSE);"))
                        session.execute(text(f"INSERT song_requests VALUES((SELECT MAX(requestId) FROM requests), '{song}');"))
                        session.commit()
    else:
        st.write("Access denied, please log in or register an account")
except:
    st.write("Access denied, please log in or register an account")