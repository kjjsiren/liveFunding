# Associations define relationships between different entities. They can be monetary or of other kind (eg. boardmembership in a organization).
class Association < ActiveRecord::Base
	belongs_to :entities
  belongs_to :knows_entity, :class_name => 'Entity'
  belongs_to :entity, :class_name => 'Entity'
  
  validates_presence_of :description, :infosource  

end
