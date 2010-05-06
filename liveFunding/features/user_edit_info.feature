Feature: User editing their information
	In order to edit my personal information, change password or profile picture
	As a registered user
	I want to edit my password and homepage URL

Scenario: Edit existing users information
	Given I am logged_in 
	And I go to my profile
	
	And I fill in "user_password" with "54321"
	And I fill in "user_password_confirmation" with "54321"
	And I fill in "user_link" with "www.test.com"
	And I press "Update"
	
	Then I should see "Details were successfully updated"
	And the "Homepage/URL" field should contain "www.test.com"
	
	When I follow "logout"
	And I am logged_in as "test" with password "54321"
	
	Then I should be on home_page
	And I should not see "Login failed"