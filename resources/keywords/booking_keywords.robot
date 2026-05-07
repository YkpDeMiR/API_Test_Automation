*** Settings ***
Library    RequestsLibrary
Library    Collections
Resource   ../variables/common_variables.robot
Resource   ../variables/test_data.robot

*** Keywords ***
Create Booking
    [Arguments]    ${token}
    ${headers}=    Create Dictionary
    ...    Content-Type=${CONTENT_TYPE}
    ...    Accept=${ACCEPT}
    ...    Cookie=token=${token}
    ${body}=    Create Dictionary
    ...    firstname=${FIRSTNAME}
    ...    lastname=${LASTNAME}
    ...    totalprice=${TOTAL_PRICE}
    ...    depositpaid=${DEPOSIT_PAID}
    ...    additionalneeds=${ADDITIONAL_NEEDS}
    ${dates}=    Create Dictionary
    ...    checkin=${CHECKIN}
    ...    checkout=${CHECKOUT}
    Set To Dictionary    ${body}    bookingdates=${dates}
    Create Session    booking_session    ${BASE_URL}    timeout=${TIMEOUT}
    ${response}=    POST On Session
    ...    booking_session
    ...    /booking
    ...    json=${body}
    ...    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200
    ${booking_id}=    Convert To String    ${response.json()['bookingid']}
    RETURN    ${booking_id}

Get Booking
    [Arguments]    ${booking_id}
    Create Session    booking_session    ${BASE_URL}    timeout=${TIMEOUT}
    ${response}=    GET On Session
    ...    booking_session
    ...    /booking/${booking_id}
    Should Be Equal As Integers    ${response.status_code}    200
    RETURN    ${response.json()}

Update Booking
    [Arguments]    ${booking_id}    ${token}
    ${headers}=    Create Dictionary
    ...    Content-Type=${CONTENT_TYPE}
    ...    Accept=${ACCEPT}
    ...    Cookie=token=${token}
    ${body}=    Create Dictionary
    ...    firstname=${UPDATED_FIRSTNAME}
    ...    lastname=${LASTNAME}
    ...    totalprice=${UPDATED_PRICE}
    ...    depositpaid=${DEPOSIT_PAID}
    ...    additionalneeds=${ADDITIONAL_NEEDS}
    ${dates}=    Create Dictionary
    ...    checkin=${CHECKIN}
    ...    checkout=${CHECKOUT}
    Set To Dictionary    ${body}    bookingdates=${dates}
    Create Session    booking_session    ${BASE_URL}    timeout=${TIMEOUT}
    ${response}=    PUT On Session
    ...    booking_session
    ...    /booking/${booking_id}
    ...    json=${body}
    ...    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200
    RETURN    ${response.json()}

Delete Booking
    [Arguments]    ${booking_id}    ${token}
    ${headers}=    Create Dictionary
    ...    Content-Type=${CONTENT_TYPE}
    ...    Cookie=token=${token}
    Create Session    booking_session    ${BASE_URL}    timeout=${TIMEOUT}
    ${response}=    DELETE On Session
    ...    booking_session
    ...    /booking/${booking_id}
    ...    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    201
    RETURN    ${response}

Update Booking With Invalid Token
    [Arguments]    ${booking_id}
    ${headers}=    Create Dictionary
    ...    Content-Type=${CONTENT_TYPE}
    ...    Accept=${ACCEPT}
    ...    Cookie=token=invalid_token
    ${body}=    Create Dictionary
    ...    firstname=${UPDATED_FIRSTNAME}
    ...    lastname=${LASTNAME}
    ...    totalprice=${UPDATED_PRICE}
    ...    depositpaid=${DEPOSIT_PAID}
    ...    additionalneeds=${ADDITIONAL_NEEDS}
    ${dates}=    Create Dictionary
    ...    checkin=${CHECKIN}
    ...    checkout=${CHECKOUT}
    Set To Dictionary    ${body}    bookingdates=${dates}
    Create Session    booking_session    ${BASE_URL}    timeout=${TIMEOUT}
    ${response}=    PUT On Session
    ...    booking_session
    ...    /booking/${booking_id}
    ...    json=${body}
    ...    headers=${headers}
    ...    expected_status=403
    RETURN    ${response}

Update Nonexistent Booking
    [Arguments]    ${token}
    ${headers}=    Create Dictionary
    ...    Content-Type=${CONTENT_TYPE}
    ...    Accept=${ACCEPT}
    ...    Cookie=token=${token}
    ${body}=    Create Dictionary
    ...    firstname=${UPDATED_FIRSTNAME}
    ...    lastname=${LASTNAME}
    ...    totalprice=${UPDATED_PRICE}
    ...    depositpaid=${DEPOSIT_PAID}
    ...    additionalneeds=${ADDITIONAL_NEEDS}
    ${dates}=    Create Dictionary
    ...    checkin=${CHECKIN}
    ...    checkout=${CHECKOUT}
    Set To Dictionary    ${body}    bookingdates=${dates}
    Create Session    booking_session    ${BASE_URL}    timeout=${TIMEOUT}
    ${response}=    PUT On Session
    ...    booking_session
    ...    /booking/999999
    ...    json=${body}
    ...    headers=${headers}
    ...    expected_status=405
    RETURN    ${response}

Delete Booking With Invalid Token
    [Arguments]    ${booking_id}
    ${headers}=    Create Dictionary
    ...    Content-Type=${CONTENT_TYPE}
    ...    Cookie=token=invalid_token
    Create Session    booking_session    ${BASE_URL}    timeout=${TIMEOUT}
    ${response}=    DELETE On Session
    ...    booking_session
    ...    /booking/${booking_id}
    ...    headers=${headers}
    ...    expected_status=403
    RETURN    ${response}

Get Nonexistent Booking
    Create Session    booking_session    ${BASE_URL}    timeout=${TIMEOUT}
    ${response}=    GET On Session
    ...    booking_session
    ...    /booking/999999
    ...    expected_status=404
    RETURN    ${response}

Create Booking With Missing Fields
    [Arguments]    ${token}
    ${headers}=    Create Dictionary
    ...    Content-Type=${CONTENT_TYPE}
    ...    Accept=${ACCEPT}
    ...    Cookie=token=${token}
    ${body}=    Create Dictionary
    ...    firstname=${FIRSTNAME}
    ...    lastname=${LASTNAME}
    Create Session    booking_session    ${BASE_URL}    timeout=${TIMEOUT}
    ${response}=    POST On Session
    ...    booking_session
    ...    /booking
    ...    json=${body}
    ...    headers=${headers}
    ...    expected_status=500
    RETURN    ${response}