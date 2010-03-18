class Renamecolumnsinassociations < ActiveRecord::Migration
  def self.up
      rename_column :associations, :entity_id, :from_id
      rename_column :associations, :thirdpartyperson_id, :to_id  
    end

    def self.down
      rename_column :associations, :from_id, :entity_id
      rename_column :associations, :to_id, :thirdpartyperson_id  
    end
end
