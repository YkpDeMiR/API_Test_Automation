*** Settings ***
Library     RequestsLibrary
Resource    ../../resources/keywords/auth_keywords.robot
Resource    ../../resources/keywords/booking_keywords.robot
Resource    ../../resources/variables/common_variables.robot
Resource    ../../resources/variables/test_data.robot
Library     ../../resources/libraries/CustomLibrary.py

*** Test Cases ***
TC01 - Booking Should Be Deleted Successfully
    ${token}=    Get Auth Token
    ${booking_id}=    Create Booking    ${token}
    Delete Booking    ${booking_id}    ${token}
    Log    Deleted Booking ID: ${booking_id}

TC02 - Deleted Booking Should Not Be Accessible
    ${token}=    Get Auth Token
    ${booking_id}=    Create Booking    ${token}
    Delete Booking    ${booking_id}    ${token}
    ${response}=    Get Nonexistent Booking
    Validate Response Status    ${response}    404

TC03 - Booking Should Not Be Deleted With Invalid Token
    ${token}=    Get Auth Token
    ${booking_id}=    Create Booking    ${token}
    ${response}=    Delete Booking With Invalid Token    ${booking_id}
    Should Be Equal As Integers    ${response.status_code}    403