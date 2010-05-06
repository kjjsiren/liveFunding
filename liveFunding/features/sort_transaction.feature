Feature: Sort Transaction

Scenario: Sorting the transactions by Amount
	When I go to home_page
	And I follow "Transactions"
	Then I should be on the transaction_page
	And I should not see "▼"
	And I should not see "▲"
	And I follow "Amount"
	And I should see "▼"
	And I should see "Transaction has been ranked by amount"
	And I follow "Amount"
	And I should see "▲"
	And I should see "Transaction has been ranked by amount"
	Then I should be on the transaction_page
	Then show me the page
	
Scenario: Sorting the transactions by From
	When I go to home_page
	And I follow "Transactions"
	Then I should be on the transaction_page
	And I should not see "▼"
	And I should not see "▲"
	And I follow "From"
	And I should see "▼"
	And I follow "From"
	And I should see "▲"
	Then I should be on the transaction_page
	Then show me the page
	
	
Scenario: Sorting the transactions by To
	When I go to home_page
	And I follow "Transactions"
	Then I should be on the transaction_page
	And I should not see "▼"
	And I should not see "▲"
	And I follow "To"
	And I should see "▼"
	And I follow "To"
	And I should see "▲"
	Then I should be on the transaction_page
	Then show me the page

Scenario: Sorting the transactions by Create Time
	When I go to home_page
	And I follow "Transactions"
	Then I should be on the transaction_page
	And I should not see "▼"
	And I should not see "▲"
	And I follow "Create Time"
	And I should see "▼"
	And I follow "Create Time"
	And I should see "▲"
	Then I should be on the transaction_page
	Then show me the page