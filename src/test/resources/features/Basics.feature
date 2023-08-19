Feature: Security Token Tests

Background: 
Given url "https://tek-insurance-api.azurewebsites.net"
And path "/api/token"

Scenario: Generate valid token with valid username and password
#Prepare request
And request {"username": "supervisor","password": "tek_supervisor"}
When method post
Then status 200
And print response


Scenario: Validate token with invalid username
And request {"username": "wrongusername","password": "tek_supervisor"}
When method post
Then status 400
And print response
And assert response.errorMessage == "User not found"


# Note if you want to comment any line use hash "#" in the begining. 
#Note: the request body has to be in one line but if you want to put in mulitiple lines then you can 3 double cotation on the top and 
# 2 in the bottom. 
#And request
#"""
#{
# "username": "string",
#  "password": "string"
#}
#"""
#we can put repeatative steps under backround in entire feature.

Scenario: Validate token with invalide password
And request 
"""
{
  "username": "supervisor",
  "password": "wrongpassword"
}
"""
And method post
Then status 400
And print response 
And assert response.errorMessage == "Password Not Matched"

#now if we want to make it more clear so we can use scenario outline. See next page.
