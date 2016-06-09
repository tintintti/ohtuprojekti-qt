Feature: As a community manager I want to see code review users and their
domains.

@javascript
Scenario: User views gerrit charts
Given there is data in the database
Given I have logged in
When I go to gerrit charts
Then I should see "gerrit stuff"
