*** Settings ***
Library     RequestsLibrary
Resource    ../../resources/keywords/auth_keywords.robot
Resource    ../../resources/keywords/booking_keywords.robot
Resource    ../../resources/variables/common_variables.robot
Resource    ../../resources/variables/test_data.robot
Library    ../../resources/libraries/CustomLibrary.py



*** Test Cases ***
TC01 - All Bookings Should Be Listed
    Create Session    booking_session    ${BASE_URL}    timeout=${TIMEOUT}
    ${response}=    GET On Session    booking_session    /booking
    Should Be Equal As Integers    ${response.status_code}    200
    Log    ${response.json()}

TC02 - Created Booking Should Be Validated
    ${token}=    Get Auth Token
    ${booking_id}=    Create Booking    ${token}
    ${booking}=    Get Booking    ${booking_id}
    Validate Booking Fields    ${booking}    Yakup    Demir    150
    Log    ${booking}

TC03 - Nonexistent Booking Should Not Be Retrieved
    ${response}=    Get Nonexistent Booking
    Should Be Equal As Integers    ${response.status_code}    404
    Log    ${response.status_code}







