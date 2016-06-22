Feature: As a community manager I want to see code review users and their
domains.

@javascript
Scenario: User views owner data piecharts
Given there is data in the database
Given I have logged in
When I go to gerrit charts
When I press "Change owners"
Then there should be a piechart
Then there should be a barchart
Then I should see "testOwner1"
Then I should see "testOwner2"
Then I should see "testOwner3"

@javascript
Scenario: User views change passing statistics
Given there is data in the database
Given I have logged in
When I go to gerrit charts
When I press "Passed changes"
Then I should see "Average time for a change to pass CI:"

@javascript
Scenario: User views user domain piechart
Given there is data in the database
Given I have logged in
When I go to gerrit charts
When I press "Owner domains"
Then I should see "Owner domains"
Then I should see "email"
