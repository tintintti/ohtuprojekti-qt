Feature: As a community manager I want to see who has committed to which
git repos.

@javascript
Scenario: User views git charts
Given there is data in the database
Given I have logged in
When I go to git charts
Then I should see "Git-kaaviot"
