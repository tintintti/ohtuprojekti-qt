Feature: As a community manager I want to see who has posted messages on
the forum.

@javascript
Scenario: User views the users in the post chart
Given I have logged in
Given there is data in the database
When I go to forum charts
When I press "Users"
Then I should see "posts by users"
Then there should be a piechart
Then I should see "testUser"
