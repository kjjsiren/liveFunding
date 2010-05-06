Feature: User registration
	In order to favourite, comment and rank transactions
	As a non-registered user
	I register as a user of the service

Scenario: User wants to register to the service
	Given I am on home_page
	And I follow "Register"
	
	Then I am on registration_page
	And I click the create_button
	
	Then I should be on the home_page
	
	