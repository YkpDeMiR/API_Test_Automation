*** Settings ***
Library     RequestsLibrary
Resource    ../../resources/keywords/auth_keywords.robot
Resource    ../../resources/keywords/booking_keywords.robot
Resource    ../../resources/variables/common_variables.robot
Resource    ../../resources/variables/test_data.robot

*** Test Cases ***
TC01 - Booking Should Be Updated Successfully
    ${token}=    Get Auth Token
    ${booking_id}=    Create Booking    ${token}
    ${updated}=    Update Booking    ${booking_id}    ${token}
    Should Be Equal    ${updated['firstname']}    UpdatedName
    Log    Updated Booking: ${updated}

TC02 - Updated Booking Should Be Validated
    ${token}=    Get Auth Token
    ${booking_id}=    Create Booking    ${token}
    Update Booking    ${booking_id}    ${token}
    ${booking}=    Get Booking    ${booking_id}
    Should Be Equal    ${booking['firstname']}    UpdatedName
    Should Be Equal As Integers    ${booking['totalprice']}    200
    Log    ${booking}

TC03 - Booking Should Not Be Updated With Invalid Token
    ${token}=    Get Auth Token
    ${booking_id}=    Create Booking    ${token}
    ${response}=    Update Booking With Invalid Token    ${booking_id}
    Should Be Equal As Integers    ${response.status_code}    403

TC04 - Nonexistent Booking Should Not Be Updated
    ${token}=    Get Auth Token
    ${response}=    Update Nonexistent Booking    ${token}
    Should Be Equal As Integers    ${response.status_code}    405