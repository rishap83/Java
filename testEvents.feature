Feature: UI Automation Test for cloud console login

  Scenario: User visits cloud console
    When user visits cloud console home page
    Then validate cloud console home page

  Scenario: User attempts to login
    When user clicks login
    Then user should be redirected to login page

  Scenario: User enters login credentials
    When User enter valid login credentials
    Then User should be redirected to cloud console logged in home page