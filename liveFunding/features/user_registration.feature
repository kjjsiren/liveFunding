Feature: User registration
	In order to favourite, comment and rank transactions
	As a non-registered user
	I register as a user of the service

Scenario: User wants to register to the service
	Given I am on home_page
	And I follow "Register"
	
	And I am on registration_page
	And I fill in "user_username" with "test"
	And I fill in "user_firstname" with "John"
	And I fill in "user_lastname" with "Scott"
	And I fill in "user_password" with "12345"
	And I fill in "user_password_confirmation" with "12345"
	And I fill in "user_link" with "www.me.com/john"
	And I press "Create new"
	
	Then I should be on home_page