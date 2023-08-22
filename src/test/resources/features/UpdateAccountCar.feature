@Regression
Feature: update account car features

Background: setup tests
Given url "https://tek-insurance-api.azurewebsites.net"
* def accountCreationResult = callonce read('CreateAccount.feature')
* def validToken = accountCreationResult.validToken
* def accountId = accountCreationResult.response.id

Scenario: update existing car info from account

Given path "/api/accounts/add-account-car"
And param primaryPersonId = accountId
And header Authorization = "Bearer " + validToken
And request 
"""
{
    "make": "Fort",
    "model": "Mustang",
    "year": "2021",
    "licensePlate": "xyz-111"
}
""" 
And method post
Then status 201
And print response
And assert response.make == "Fort"
And assert response.year == "2021"

* def carId = response.id
Given path "/api/accounts/update-account-car"
And header Authorization = "Bearer " + validToken
And param primaryPersonId = accountId
And request 
"""
{
		"id":		"#(carId)",
    "make": "Honda",
    "model": "Odessy",
    "year": "2021",
    "licensePlate": "xyz-222"
}
""" 
And method put
Then status 202
And print response
And assert response.make == "Honda"
