Feature: Transaction

Scenario: Create a new transaction with amount
	When I go to home_page
	And I follow "New Transaction"
	And I fill in "Information Source:" with "test"
	And I fill in "Information" with "Test!"
	And I fill in the amount "300"

	And I press "Create new"
	Then I should be on transaction_show_page
	And I should see "Transaction was successfully created."
	
Scenario: Create a new transaction without amount
	When I go to home_page
	And I follow "New Transaction"
	And I fill in "Information Source:" with "test"
	And I fill in "Information" with "Test!"

	And I press "Create new"
	Then I should be on transactions_listing_page
	And I should see "Transaction creation failed."
	
Scenario: Create a new transaction without information source and information
	When I go to home_page
	And I follow "New Transaction"
	And I fill in the amount "300"

	And I press "Create new"
	Then I should be on transaction_show_page
	And I should see "Transaction was successfully created."
	
Scenario: Create a new transaction without information source
	When I go to home_page
	And I follow "New Transaction"
	And I fill in "Information" with "Test!"
	And I fill in the amount "300"

	And I press "Create new"
	Then I should be on transaction_show_page
	And I should see "Transaction was successfully created."