*** Settings ***
Library     RequestsLibrary
Resource    ../../resources/keywords/auth_keywords.robot
Resource    ../../resources/variables/common_variables.robot

*** Test Cases ***
TC01 - Auth Token Should Be Retrieved Successfully
    ${token}=    Get Auth Token
    Should Not Be Empty    ${token}
    Log    Token: ${token}

TC02 - Auth Token Should Not Be Retrieved With Invalid Username
    ${body}=    Create Dictionary
    ...    username=invalid_user
    ...    password=password123
    Create Session    auth_session    ${BASE_URL}    timeout=${TIMEOUT}
    ${response}=    POST On Session
    ...    auth_session
    ...    /auth
    ...    json=${body}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal    ${response.json()['reason']}    Bad credentials

TC03 - Auth Token Should Not Be Retrieved With Invalid Password
    ${body}=    Create Dictionary
    ...    username=admin
    ...    password=wrong_password
    Create Session    auth_session    ${BASE_URL}    timeout=${TIMEOUT}
    ${response}=    POST On Session
    ...    auth_session
    ...    /auth
    ...    json=${body}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal    ${response.json()['reason']}    Bad credentials