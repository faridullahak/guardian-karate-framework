@Regression
Feature: Create Account feature

  Background: Setup test and generate token.
    * def result = callonce read('GenerateToken.feature')
    * def validToken = result.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Create valid account
    Given path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer " + validToken
    #Calling Java class in feature file. this utility will create object from Java Class. 
    * def generateDataObject = Java.type('api.utility.data.GenerateData')
    * def autoEmail = generateDataObject.getEmail()
    And request
      """
      {
      "email": "#(autoEmail)",
      "firstName": "Storme",
      "lastName": "Hurrican",
      "title": "Mr.",
      "gender": "MALE",
      "maritalStatus": "SINGLE",
      "employmentStatus": "Software destroyer",
      "dateOfBirth": "1900-02-27"
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.email == autoEmail