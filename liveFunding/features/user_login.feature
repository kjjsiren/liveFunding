Feature: User login
	In order to favorite, rank and comment transactions
	As a registered user
	The user logs in

Scenario: Login in as an existing user
	When I go to home_page
	And I fill in "user_username" with "antti"
	And I fill in "user_password" with "12345"
	And I press "Submit"
	
	Then I should be on the homepage
	And I should see a message that says "Welcome, antti"