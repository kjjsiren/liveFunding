Feature: Adding a comment
	I like to comment a transaction in the transaction view
	And then read the posted comments
	
Scenario: Adding a comment
	Given I am logged_in
	And I am on transactions_listing_page
	And I follow "Comment"
	Then I should be on transactions_listing_page