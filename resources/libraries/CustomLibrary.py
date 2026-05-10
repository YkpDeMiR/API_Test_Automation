import json
from robot.api.deco import keyword


class CustomLibrary:

    @keyword("Create Auth Headers")
    def create_auth_headers(self, token):
        return {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Cookie": f"token={token}"
        }

    @keyword("Create Booking Body")
    def create_booking_body(self, firstname, lastname, totalprice,
                             depositpaid, checkin, checkout, additionalneeds):
        return {
            "firstname": firstname,
            "lastname": lastname,
            "totalprice": totalprice,
            "depositpaid": depositpaid,
            "additionalneeds": additionalneeds,
            "bookingdates": {
                "checkin": checkin,
                "checkout": checkout
            }
        }

    @keyword("Create Invalid Auth Headers")
    def create_invalid_auth_headers(self):
        return {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Cookie": "token=invalid_token"
        }

    @keyword("Validate Response Status")
    def validate_response_status(self, response, expected_status):
        actual = response.status_code
        assert actual == int(expected_status), \
            f"Expected {expected_status} but got {actual}"

    @keyword("Validate Field Equals")
    def validate_field_equals(self, response_json, field, expected_value):
        actual = response_json.get(field)
        assert str(actual) == str(expected_value), \
            f"Field '{field}': expected '{expected_value}' but got '{actual}'"

    @keyword("Validate Field Not Empty")
    def validate_field_not_empty(self, value):
        assert value is not None and str(value) != "", \
            f"Expected non-empty value but got '{value}'"

    @keyword("Validate Fields Not Empty")
    def validate_fields_not_empty(self, response_json, *fields):
        for field in fields:
            value = response_json.get(field)
            assert value is not None and str(value) != "", \
                f"Field '{field}' is empty or missing"

    @keyword("Log Response Details")
    def log_response_details(self, response):
        print(f"\nStatus Code  : {response.status_code}")
        print(f"Response Time: {response.elapsed.total_seconds()}s")
        try:
            print(f"Body         : {json.dumps(response.json(), indent=2)}")
        except Exception:
            print(f"Body         : {response.text}")

    @keyword("Validate Booking Fields")
    def validate_booking_fields(self, booking, firstname, lastname, totalprice):
        assert booking.get("firstname") == firstname, \
            f"firstname: expected '{firstname}' got '{booking.get('firstname')}'"
        assert booking.get("lastname") == lastname, \
            f"lastname: expected '{lastname}' got '{booking.get('lastname')}'"
        assert str(booking.get("totalprice")) == str(totalprice), \
            f"totalprice: expected '{totalprice}' got '{booking.get('totalprice')}'"