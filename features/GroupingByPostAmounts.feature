Feature: As a community manager I want to define how to group users by post
amounts (with less/more than x posts).

@javascript
Scenario: User sets the minimum amount of posts in the post chart
Given I have logged in
Given there is data in the database
When I go to forum charts
When I press "Viestien lähettäjät"
When I fill in "minimum" with "15"
When I press "Aseta viestien minimimäärä"
Then I should see "users w/ <15 posts"
