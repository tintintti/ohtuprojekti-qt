Feature: As a community manager I want to see code review users and their
domains.

@javascript
Scenario: User views gerrit owner data charts
Given there is data in the database
Given I have logged in
When I go to gerrit charts
When I press "Change owners"
Then I should see a pie chart with change owner data
Then I should see a bar chart with change owner data


@javascript
Scenario: User views change passing statistics
Given there is data in the database
Given I have logged in
When I go to gerrit charts
When I press "Passed changes"
Then I should see "Average time for a change to pass CI: 0 days, 1 hours, 0 minutes"
Then I should see a bar chart with change revision data
Then I should see a bar chart with change time to pass data

@javascript
Scenario: User views user domain piechart
Given there is data in the database
Given I have logged in
When I go to gerrit charts
When I press "Owner domains"
Then I should see a pie chart with change owner domains
