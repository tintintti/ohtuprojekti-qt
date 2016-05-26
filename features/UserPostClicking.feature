Feature: As a community manager I want to be able to click a username
to redirect me to forum user information.

@javascript
Scenario: User clicks on pie chart object
When I go to charts
When I press "Viestien lähettäjät"
When I click a slice on piechart
Then I should be on user's forum page
