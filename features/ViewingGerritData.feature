Feature: As a community manager I want to see code review users and their
domains.

@javascript
Scenario: User views owner pie chart
Given there is data in the database
Given I have logged in
When I go to gerrit charts
When I press "Muutosten omistajat"
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
When I press "Muutosten läpimeno"
Then I should see "Keskimääräinen aika, että muutos menee läpi:"

@javascript
Scenario: User views change passing statistics
Given there is data in the database
Given I have logged in
When I go to gerrit charts
When I press "Omistajien domainit"
Then I should see "Omistajien eri domainien määrät"
Then I should see "email"
