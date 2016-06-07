Feature: As a community manager I want to see who is doing stuff with gerrit.

@javascript
Scenario: User views gerrit stuff
Given there is data in the database
Given I have logged in
When I go to gerrit charts
Then I should see "gerrit stuff"
