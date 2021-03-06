Feature: As a community manager I want to see a bar-chart representation of
user post amounts as 1-10, 11-50 etc.

@javascript
Scenario: User views the user post amounts in the bar chart
Given I have logged in
Given there is data in the database
When I go to forum charts
When I press "Users"
Then I should see "Users by postcount"
Then there should be a barchart with post data
