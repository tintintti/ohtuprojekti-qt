Feature: As a community manager I want to see who has committed to which
git repos.

@javascript
Scenario: User views git committers
Given there is data in the database
Given I have logged in
When I go to git charts
When I limit authors to 1
When I press "Näytä committaajat"
Then I should see "testAuthor"
Then I should not see "testAuthor2"
When I limit authors to 5
When I press "Näytä committaajat"
Then I should see "testAuthor13"
#Order is reversed, everyone has the same amount of commits
Then I should see "testAuthor12"
Then I should see "testAuthor9"
Then I should not see "testAuthor8"
Then I should not see "testAuthor7"
Then I should not see "testAuthor5"
When I limit commit count to start from 1/1/2017
When I press "Näytä committaajat"
Then I should not see "testAuthor"
When I limit commit count to start from 1/1/2000
When I press "Näytä committaajat"
Then I should see "testAuthor"


@javascript
Scenario: User views git committers by activity
Given there is data in the database
Given I have logged in
When I go to git charts
When I press "Näytä committaajien jakauma aktiivisuuden mukaan"
Then I should see "13"
Then I limit authors to 0
When I press "Näytä committaajien jakauma aktiivisuuden mukaan"
Then I should not see "13"

@javascript
Scenario: User views git committer domains
Given there is data in the database
Given I have logged in
When I go to git charts
When I press "Näytä committaajien domainit"
Then I should see "test"
When I limit commit count to start from 1/1/2017
When I press "Näytä committaajien domainit"
Then I should not see "test"
When I limit commit count to start from 1//1/2000
When I press "Näytä committaajien domainit"
Then I should see "test"
When I limit authors to 0
When I press "Näytä committaajien domainit"
Then I should not see "test"
When I limit authors to 1
When I press "Näytä committaajien domainit"
Then I should see "test"
