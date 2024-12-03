import streamlit as st
import numpy as np
import matplotlib as mp
import matplotlib.pyplot as plt
import random as rd

def main():
    st.set_page_config(
        page_title = "CU Pep Band Database",
        page_icon = "https://upload.wikimedia.org/wikipedia/en/thumb/6/6f/Creighton_Bluejays_logo.svg/640px-Creighton_Bluejays_logo.svg.png",
    )
    st.title("CU Pep Band Database - Homepage")
    col1, col2 = st.columns(2)
    with col1:
        st.image("resources\pep_home_1.jpg")
        st.image("resources\pep_home_2.jpg")
    with col2:
        st.image("resources\pep_home_3.jpg")
        st.image("resources\pep_home_4.jpg")
    st.write("The Creighton University Pep Band is a student led organization within the Athletic Department. We pride ourselves on being the biggest student-fans around, who just happen to have musical ability. The band plays at all Women's Volleyball, Women's Basketball, and Men's Basketball games, as well as special Athletic Department events. Thus, band members are guaranteed seating at all volleyball and basketball games, as well as a free meal before each game. The band also has the opportunity to support both the men's and women's basketball teams in their postseason tournaments! Be sure to show up to one of our practices to learn more!")
    st.sidebar.success("Select a page")

if __name__=="__main__":
    main()
