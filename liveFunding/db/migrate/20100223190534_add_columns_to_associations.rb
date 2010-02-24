class AddColumnsToAssociations < ActiveRecord::Migration
  def self.up
  	add_column :associations, :entity_id, :integer
  	add_column :associations, :thirdpartyperson_id, :integer
  end

  def self.down
  	remove_column :associations, :entity_id
  	remove_column :associations, :thirdpartyperson_id
  end
end
