Feature: Hello Cucumber
As a community manager I want to see who has posted messages on the forum

@javascript
Scenario: User sees the welcome message
Given I have logged in
When I go to the home page
Then page should have text message "Qt Software Project"

@javascript
Scenario: User checks user post chart
Given I have logged in
When I go to forum charts
When I press "Viestien lähettäjät"
Given there is data in the database
Then there should be a piechart
