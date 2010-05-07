Feature: User login
	In order to favorite, rank and comment transactions
	As a registered user
	The user logs in

Scenario: Login in as an existing user
	When I go to home_page
	And I am logged_in
	
	Then I should be on home_page
	