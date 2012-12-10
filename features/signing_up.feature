Feature: Signing up
In order to be attributed for my work
As a user
I want to be able to sign up

Scenario: Signing up
	Given I am on the homepage
	When I click Sign up	
    And I fill in "Email" with "user@the-camp.org"
  	# And I fill in "Password" with "passwords"
  	# And I fill in "Password confirmation" with "passwords"
	And I fill in "user_password" with "passwords"
  	And I fill in "user_password_confirmation" with "passwords"
  	And I press "Sign up"
	Then I should see "You have signed up successfully."
