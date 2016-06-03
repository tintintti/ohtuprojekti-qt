Feature: As a community manager I want to see the users
of the email provider I place my mouse pointer upon.

@javascript
Scenario: User sees some of the users of a provider when
hovering the cursor over a slice in the email chart
Given there is data in the database
Given I have logged in
When I go to forum charts
When I press "Sähköpostien palveluntarjoajat"
When I hover mouse over a slice on piechart
Then I should see some email provider users

@javascript
Scenario: User sees a list of all users of a provider by clicking a slice
in the email chart
Given I have logged in
Given there is data in the database
When I go to forum charts
When I press "Sähköpostien palveluntarjoajat"
When I click a slice on piechart
Then I should see email users as a list
