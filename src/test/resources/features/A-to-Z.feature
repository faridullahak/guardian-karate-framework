@TaskCompleted
Feature: Home Work features


Background: initial steps for all features
Given url "https://tek-insurance-api.azurewebsites.net"
* def result = callonce read('CreateAccount.feature')
* def validToken = result.validToken
* def validId = result.response.id 
And print result 

#* def result1 = callonce read('GenerateToken.feature')
#* def validToken = result1.response.token
Scenario: Add phone
 Given path "/api/accounts/add-account-phone"
    And param primaryPersonId = validId
  And header Authorization = "Bearer " + validToken
     * def dataGenerator = Java.type('api.utility.data.GenerateData')
    * def phoneNumber = dataGenerator.getPhoneNumber()
    And request
      """
      {
      "phoneNumber": "#(phoneNumber)",
      "phoneExtension": "3",
      "phoneTime": "Evening",
      "phoneType": "Mobile"
      }
      """
    When method post
  	And status 201
    And assert response.phoneNumber == phoneNumber
  
 Scenario: Adding address
 Given path "/api/accounts/add-account-address"
    And param primaryPersonId = validId
  And header Authorization = "Bearer " + validToken
    And request
      """
      {
  "addressType": "Home",
  "addressLine1": "Heven St 5",
  "city": "Durham",
  "state": "VA",
  "postalCode": "555",
  "countryCode": "United States",
  "current": true
}
      """
    When method post
  	And status 201
    And assert response.current == true
    
Scenario: Add car
 Given path "/api/accounts/add-account-car"
    And param primaryPersonId = validId
    And header Authorization = "Bearer " + validToken   
    And request
      """
     {
  "make": "Honda",
  "model": "Odessey",
  "year": "2005",
  "licensePlate": "ABC-555"
}
      """
    When method post
  	And status 201
    And assert response.make == "Honda"
    
Scenario: Deletion 
    Given path "/api/accounts/delete-account"
    And param primaryPersonId = validId
    And header Authorization = "Bearer " + validToken
    When method delete
    Then status 200
    And print response
    And assert response == "Account Successfully deleted"
    
    
    
    
    