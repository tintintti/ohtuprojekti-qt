Feature:
As a community manager I want to see the users of
 the email provider I place my cursor upon.

 @javascript
 Scenario: Community manager checks email provider chart
 Given I have logged in
 When I go to forum charts
 When I press "Sähköpostien palveluntarjoajat"
 Given there is data in the database
 Then there should be a piechart
