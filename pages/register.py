
import yaml
import streamlit as st
from yaml.loader import SafeLoader
import streamlit_authenticator as stauth
from streamlit_authenticator.utilities import (CredentialsError,
                                               ForgotError,
                                               Hasher,
                                               LoginError,
                                               RegisterError,
                                               ResetError,
                                               UpdateError)

def main():
    st.title("Register New Account")
    with open(r'C:\Users\jonah\OneDrive\Desktop\Workspace\College\Creighton 2024-25\CSC 548\Final Project\pages\profiles.yaml') as file:
        config = yaml.load(file, Loader=SafeLoader)
    authenticator = stauth.Authenticate(
        config['credentials'],
        config['cookie']['name'],
        config['cookie']['key'],
        config['cookie']['expiry_days']
    )
    try:
        (email_of_registered_user,
            username_of_registered_user,
            name_of_registered_user) = authenticator.register_user(roles=["USER"])
        if email_of_registered_user:
            st.success('User registered successfully')
    except RegisterError as e:
        st.error(e)

    with open(r'C:\Users\jonah\OneDrive\Desktop\Workspace\College\Creighton 2024-25\CSC 548\Final Project\pages\profiles.yaml', 'w', encoding='utf-8') as file:
        yaml.dump(config, file, default_flow_style=False)
if __name__ == "__main__":
    main()