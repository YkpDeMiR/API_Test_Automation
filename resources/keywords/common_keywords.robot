*** Settings ***
Library    RequestsLibrary
Library    ../libraries/CustomLibrary.py
Resource   ../variables/common_variables.robot


*** Keywords ***
Create Authenticated Session
    [Arguments]    ${alias}
    Create Session    ${alias}    ${BASE_URL}    timeout=${TIMEOUT}

Log Response
    [Arguments]    ${response}
    Log Response Details    ${response}
