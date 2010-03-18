class RenameColumnsInAssociations2 < ActiveRecord::Migration
  def self.up
       rename_column :associations, :from_id, :entity_id
       rename_column :associations, :to_id, :knows_entity_id  
     end

     def self.down
       rename_column :associations, :entity_id, :from_id
       rename_column :associations, :knows_entity_id, :to_id  
     end
end
