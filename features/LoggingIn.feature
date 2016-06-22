Feature: As a community manager I want to sign in to access the data.

 @javascript
 Scenario: User tries to access charts without logging in
 When I go to forum charts
 Then I should be on the login page

 @javascript
 Scenario: User logs in successfully and is redirected to home page
 When I log in successfully
 Then I should be on the home page
 Then page should have text message "Welcome!"

 @javascript
 Scenario: User tries to log in but fails because of wrong password
 When I try to log in with wrong password
 Then I should be on the login page
 Then page should have text message "Invalid username or password."

 @javascript
 Scenario: User logs out and is redirected to home page
 Given I have logged in
 When I click "Log out"
 Then I should be on the home page
 Then page should have text message "Logged out."
