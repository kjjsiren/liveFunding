Feature: Sort Transaction

Scenario: Sorting the transactions by Amount
	When I go to home_page
	And I follow "Transactions"
	Then I should be on the transaction_page
	And I should not see "▼"
	And I should not see "▲"
	And I follow "Amount"
	And I should see "▼"
	And I follow "Amount"
	And I should see "▼"
	Then I should be on the transaction_page
	Then show me the page
	
Scenario: Sorting the transactions by From
	When I go to home_page
	And I follow "Transactions"
	
	Then I should be on the transaction_page
	And I follow "From"
	
	Then I should be on the from_page
	
	
Scenario: Sorting the transactions by To
	When I go to home_page
	And I follow "Transactions"
	
	Then I should be on the transaction_page
	And I follow "To"
	
	Then I should be on the to_page

Scenario: Sorting the transactions by Create Time
	When I go to home_page
	And I follow "Transactions"
	
	Then I should be on the transaction_page
	And I follow "Create Time"
	
	Then I should be on the createtime_page