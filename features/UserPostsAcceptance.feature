Feature: Hello Cucumber
As a community manager I want to see who has posted messages on the forum

@javascript
Scenario: User sees the welcome message
When I go to the home page
Then page should have text message "Qt Software Project"

@javascript
Scenario: User checks user post chart
When I go to charts
When I press "Viestien lähettäjät"
Then there should be a piechart
