class Association < ActiveRecord::Base
	belongs_to :entities
  belongs_to :knows_entity, :class_name => 'Entity'
  belongs_to :entity, :class_name => 'Entity'
	#belongs_to :thirdpartyperson
end
