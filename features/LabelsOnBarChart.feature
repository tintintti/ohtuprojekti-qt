Feature: As a community manager I want to see labels on user post bar chart.

@javascript
Scenario: User views the post barchart that has labels
Given I have logged in
Given there is data in the database
When I go to forum charts
When I press "Viestien lähettäjät"
Then there should be proper labels on the post barchart
