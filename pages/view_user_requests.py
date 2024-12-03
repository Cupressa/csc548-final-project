import streamlit as st
from sqlalchemy.sql import text

if st.session_state['authentication_status']:
    if st.session_state["roles"][0] in ["EXECUTIVE", "ADMINISTRATOR"]:
        conn = st.connection(
            "sql",
            dialect="mysql",
            host="localhost",
            database = "csc548band",
            username = "pep_user",
            password = "userProfile",
        )
        requestDF = conn.query("SELECT r.requestId AS requestId, netId, request_timestamp, complete, section, song_title FROM requests r LEFT JOIN folder_requests f ON r.requestId = f.requestId LEFT JOIN song_requests s ON s.requestId = r.requestId WHERE complete = 0;", ttl=0)
        st.title("View folder and song requests")
        st.write(requestDF)
        st.write("Mark request as complete")
        completeId = st.selectbox(
            "Select completed request ID", [f"{row.requestId}" for row in requestDF.itertuples()]
        )
        if(st.button("Mark as complete")):
            with conn.session as session:
                session.execute(text(f"UPDATE requests SET complete=1 WHERE requestId={completeId};"))
                session.commit()

    else:
        st.write("Access denied, please log in or register an account")