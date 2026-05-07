*** Settings ***
Library     RequestsLibrary
Resource    ../../resources/keywords/auth_keywords.robot
Resource    ../../resources/keywords/booking_keywords.robot
Resource    ../../resources/variables/common_variables.robot
Resource    ../../resources/variables/test_data.robot

*** Test Cases ***
TC01 - Full Booking Flow Should Be Completed Successfully
    # 1. Get Token
    ${token}=    Get Auth Token
    Should Not Be Empty    ${token}
    Log    Token retrieved: ${token}

    # 2. Create Booking
    ${booking_id}=    Create Booking    ${token}
    Should Not Be Empty    ${booking_id}
    Log    Booking created: ${booking_id}

    # 3. Get and Validate Booking
    ${booking}=    Get Booking    ${booking_id}
    Should Be Equal    ${booking['firstname']}    Yakup
    Should Be Equal    ${booking['lastname']}    Demir
    Log    Booking validated: ${booking}

    # 4. Update Booking
    ${updated}=    Update Booking    ${booking_id}    ${token}
    Should Be Equal    ${updated['firstname']}    UpdatedName
    Log    Booking updated: ${updated}

    # 5. Delete Booking
    Delete Booking    ${booking_id}    ${token}
    Log    Booking deleted: ${booking_id}

    # 6. Validate Deletion
    Create Session    booking_session    ${BASE_URL}    timeout=${TIMEOUT}
    ${response}=    GET On Session
    ...    booking_session
    ...    /booking/${booking_id}
    ...    expected_status=404
    Should Be Equal As Integers    ${response.status_code}    404
    Log    Full flow completed successfully!

TC02 - Full Flow Should Fail With Invalid Auth
    # 1. Try Invalid Auth
    ${body}=    Create Dictionary
    ...    username=invalid
    ...    password=invalid
    Create Session    auth_session    ${BASE_URL}    timeout=${TIMEOUT}
    ${response}=    POST On Session
    ...    auth_session
    ...    /auth
    ...    json=${body}
    Should Be Equal    ${response.json()['reason']}    Bad credentials
    Log    Invalid auth validated!