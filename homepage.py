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
    st.sidebar.success("Select a page")

if __name__=="__main__":
    main()
