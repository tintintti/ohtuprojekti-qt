Feature: As a community manager I want to see the users
of the email provider I place my mouse pointer upon.

@javascript
Scenario: Community manager places mouse over an email provider chart slice
Given there is data in the database
When I go to charts
When I press "Sähköpostien palveluntarjoajat"
When I hover mouse over a slice on piechart
Then I should see some email provider users

@javascript
Scenario: Community manager clicks an email provider chart slice
Given there is data in the database
When I go to charts
When I press "Sähköpostien palveluntarjoajat"
When I click a slice on piechart
Then I should see email users as a list
