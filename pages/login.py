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
    st.title("Login")
    with open(r'C:\Users\jonah\OneDrive\Desktop\Workspace\College\Creighton 2024-25\CSC 548\Final Project\pages\profiles.yaml') as file:
        config = yaml.load(file, Loader=SafeLoader)
    authenticator = stauth.Authenticate(
        config['credentials'],
        config['cookie']['name'],
        config['cookie']['key'],
        config['cookie']['expiry_days']
    )
    try:
        authenticator.login()
    except LoginError as e:
        st.error(e)
    
    if st.session_state['authentication_status']:
        authenticator.logout()
        st.write(f'Welcome *{st.session_state["name"]}*')
        st.write(f'Role: *{st.session_state["roles"][0]}*')
        try:
            if authenticator.update_user_details(st.session_state['username']):
                st.success('Entry updated successfully')
                with open(r'C:\Users\jonah\OneDrive\Desktop\Workspace\College\Creighton 2024-25\CSC 548\Final Project\pages\profiles.yaml', 'w', encoding='utf-8') as file:
                    yaml.dump(config, file, default_flow_style=False)
        except UpdateError as e:
            st.error(e)
        try:
            if authenticator.reset_password(st.session_state['username']):
                st.success('Password modified successfully')
        except (CredentialsError, ResetError) as e:
            st.error(e)
    elif st.session_state['authentication_status'] is False:
        st.error('Username/password is incorrect')
    elif st.session_state['authentication_status'] is None:
        st.warning('Please enter your username and password')

if __name__ == "__main__":
    main()