@Smoke
Feature: Token Varify Feature

Background: 
Given url "https://tek-insurance-api.azurewebsites.net"
Scenario: Verify a valid token
And path "/api/token"
And request 
"""
{
  "username": "supervisor",
  "password": "tek_supervisor"
}
"""
And method post
And status 200
Then print response


And path "/api/token/verify"
And param token = response.token
And param username = "supervisor"
And method get
Then status 200
Then print response
And assert response == "true"

Scenario: Verify a valid token with invalid username

And path "/api/token"
And request 
"""
{
  "username": "supervisor",
  "password": "tek_supervisor"
}
"""
And method post
And status 200
Then print response

And path "/api/token/verify"
And param token = response.token
And param username = "wrongname"
And method get
And status 400
Then print response
Then response.errorMessage == "Wrong Username send along with Token"


Scenario: Verify a invalid token with valid username

And path "/api/token/verify"
And param token = "wrongtoken"
And param username = "supervisor"
And method get
Then status 400
Then print response
Then assert response.errorMessage == "Token Expired or Invalid Token"

#Scenario: valid exisiting primary person id and validate response
#
#And path "/api/accounts/add-primary-account"
#And request {"username": "supervervisor", "password": "tek_supervisor"}
#And method post
#Then print response
#And path "/api/accounts/get-account"
#Given header Authorization = "Bearer eyJraWQiOiJUZWtzY2hvb2wgSW5zdXJhbmNlIEFwcGxpY2F0aW9uIiwidHlwIjoiSldUIiwiYWxnIjoiSFM1MTIifQ.eyJhdWQiOiJVc2VyIG1hbmFnZW1lbnQgcG9ydGFsIiwic3ViIjoiU1VQRVJWSVNPUiIsImlzcyI6IlRlayBJbnN1cmFuY2UgQXBwbGljYXRpb24iLCJBdXRob3JpdGllcyI6WyJBRE1JTiJdLCJleHAiOjE2OTEzNDg2OTQsImlhdCI6MTY5MTI2MjI5NH0.noRI8oX8ZijmqfZ7p-drf_IVzWTCa0gpIEIA2FXDG8FE871AWpJouYGeXNw4mY20Z4AlVZo1kBUx-ET_R3AElw"
#And param primaryPersonId = 9565
#And method get
#Then status 200
#Then print response










