Feature: Adding a comment
	I like to comment a transaction in the transaction view
	And then read the posted comments
	
Scenario: Adding a comment
	Given I am logged_in
	And I am on transactions_listing_page
	And I follow "Comment"
	And I should be on comment_new_page
	And I fill in the comment "test_comment #1, from Cucumber"
	And I press "Submit"
	Then I should see "test_comment #1, from Cucumber"
	Then show me the page