Feature: Create A New Entity
As a registered user,
I want to create a new entity.


Scenario: Create a new entity in the system
	When I go to new_entity_path
	And I fill in "entity_name" with "An New Entity"
	And I fill in "entity_leader" with "A famous leader"
	And I fill in "entity_homepage" with "www.leader_homepage.com"
	And I fill in "entity_email" with "famous@leader.org"
	And I fill in "entity_phone_number" with "12345678"
	And I fill in "entity_description" with "Some extra information..."
	And I press "entity_submit"
	
	#Then I should be on the entity_info_path
	Then I should see "An New Entity"