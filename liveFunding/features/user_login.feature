Feature: User login

Scenario: Login in as an existing user
	When I go to home_page
	And I fill in "Username" with "antti"
	And I fill in "Password" with "12345"
	And I press "Submit"
	
	Then I should be on the homepage
	And I should see a message that says "Welcome, antti"