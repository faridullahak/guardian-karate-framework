@Regression
Feature: Generate Token for tests

Scenario: Valid token for reusablity
Given url "https://tek-insurance-api.azurewebsites.net"
Given path "/api/token"
And request {"username": "supervisor", "password": "tek_supervisor"}
And method post
Then status 200
And print response