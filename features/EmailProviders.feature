Feature:
As a community manager I want to see the users of
 the email provider I place my cursor upon.

 @javascript
 Scenario: Community manager checks email provider chart
 When I go to charts
 When I press "Sähköpostien palveluntarjoajat"
 Then there should be a piechart
