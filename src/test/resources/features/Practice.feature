Feature: Security Token Tests

Background: 
Given url "https://tek-insurance-api.azurewebsites.net"
* def result = callonce read('GenerateToken.feature')
And print result
* def validToken = result.response.token

Scenario: Validate plan code

 Given path "/api/plans/get-all-plan-code"
And header Authorization = "Bearer " + validToken
And method get
And status 200
And print response 
Then assert response[0].planExpired == false 
Then assert response[1].planExpired == false 
Then assert response[2].planExpired == false 
Then assert response[3].planExpired == false 