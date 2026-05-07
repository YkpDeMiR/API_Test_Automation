*** Settings ***
Library    RequestsLibrary
Resource   ../variables/common_variables.robot

*** Keywords ***
Get Auth Token
    ${body}=    Create Dictionary
    ...    username=${ADMIN_USERNAME}
    ...    password=${ADMIN_PASSWORD}
    Create Session    auth_session    ${BASE_URL}    timeout=${TIMEOUT}
    ${response}=    POST On Session
    ...    auth_session
    ...    /auth
    ...    json=${body}
    Should Be Equal As Integers    ${response.status_code}    200
    ${token}=    Set Variable    ${response.json()['token']}
    RETURN    ${token}