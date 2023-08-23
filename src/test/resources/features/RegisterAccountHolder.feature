# This feature is to test accountholder registeration 
#it required existing account and random username.
@Regression
Feature: register new user and new account

Background: setup tests and create new account
Given url "https://tek-insurance-api.azurewebsites.net"
* def createAccountResult = callonce read('CreateAccount.feature')
* def accountId = createAccountResult.response.id
* def fullName = createAccountResult.response.firstName + " " + createAccountResult.response.lastName

Scenario: sign up and register new user
And path "/api/sign-up/register"
    * def dataGenerator = Java.type('api.utility.data.GenerateData')
    * def auto_name = dataGenerator.getUserName()
    And request
      """
      {
      "primaryPersonId": "#(accountId)",
      "fullname": "#(fullName)",
      "username": "#(auto_name)",
      "password": "Tek@1234",
      "authority": "CUSTOMER",
      "accountType": "CUSTOMER"
      }
      """
    When method post
    Then print response
    Then status 201
    And assert response.username == auto_name
    And assert response.fullName == fullName
    And assert response.accountType == "CUSTOMER"