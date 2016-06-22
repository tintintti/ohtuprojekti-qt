Feature: As a community manager I want to see what email providers are used

@javascript
Scenario: User views the providers in the email chart
Given I have logged in
Given there is data in the database
When I go to forum charts
When I press "Email service providers"
Then I should see "Email service providers"
Then there should be a piechart
Then I should see "test"
