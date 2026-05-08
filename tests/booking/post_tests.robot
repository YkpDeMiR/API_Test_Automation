*** Settings ***
Library     RequestsLibrary
Resource    ../../resources/keywords/auth_keywords.robot
Resource    ../../resources/keywords/booking_keywords.robot
Resource    ../../resources/variables/common_variables.robot
Resource    ../../resources/variables/test_data.robot
Library    ../../resources/libraries/CustomLibrary.py

*** Test Cases ***
TC01 - New Booking Should Be Created Successfully
    ${token}=    Get Auth Token
    ${booking_id}=    Create Booking    ${token}
    Should Not Be Empty    ${booking_id}
    Log    Created Booking ID: ${booking_id}

TC02 - Created Booking Should Be Validated
    ${token}=    Get Auth Token
    ${booking_id}=    Create Booking    ${token}
    ${booking}=    Get Booking    ${booking_id}
    Validate Booking Fields    ${booking}    Yakup    Demir    150

TC03 - Booking Should Not Be Created With Missing Fields
    ${token}=    Get Auth Token
    ${response}=    Create Booking With Missing Fields    ${token}
    Should Be Equal As Integers    ${response.status_code}    500