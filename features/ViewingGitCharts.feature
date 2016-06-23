Feature: As a community manager I want to see who has committed to which
git repos.

@javascript
Scenario: User views git committers
Given there is data in the database
Given I have logged in
When I go to git charts
When I press "Show committers"
Then I should see a pie chart of git committers
When I limit authors to 0
When I press "Show committers"
Then I should not see git committers
When I limit authors to 1
When I press "Show committers"
Then I should see a pie chart with one git committer
When I limit commit count to start from 1/1/2017
When I press "Show committers"
Then I should not see git committers
When I limit commit count to start from 1/1/2000
When I press "Show committers"
Then I should see a pie chart of git committers

@javascript
Scenario: User views git committer domains
Given there is data in the database
Given I have logged in
When I go to git charts
When I press "Show committer domains"
Then I should see a pie chart of committer domains
When I limit commit count to start from 1/1/2017
When I press "Show committer domains"
Then I should not see committer domains


@javascript
Scenario: User views git committers by activity
Given there is data in the database
Given I have logged in
When I go to git charts
When I press "Show committer distribution by activity"
Then I should see a bar chart of git committers
Then I limit authors to 2
When I press "Show committer distribution by activity"
Then I should see a bar chart with 2 git committers
