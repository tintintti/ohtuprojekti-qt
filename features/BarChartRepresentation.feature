Feature: As a community manager I want to see a bar-chart representation of
user post amounts as 1-10, 11-50 etc.

@javascript
Scenario: User views the user post amounts in the bar chart
Given I have logged in
Given there is data in the database
When I go to forum charts
When I press "Viestien lähettäjät"
Then I should see "Käyttäjät viestimäärien mukaan"
Then there should be a barchart
