*** Settings ***
Library    RequestsLibrary
Library    ../../resources/libraries/CustomLibrary.py
Resource   ../variables/common_variables.robot
Library    ../../resources/libraries/CustomLibrary.py

*** Keywords ***
Create Authenticated Session
    [Arguments]    ${alias}
    Create Session    ${alias}    ${BASE_URL}    timeout=${TIMEOUT}

Log Response
    [Arguments]    ${response}
    Log Response Details    ${response}