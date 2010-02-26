class ChangeColumnstoAssociations3 < ActiveRecord::Migration
  def self.up
     change_column :associations, :thirdpartyperson_id, :string
   end

   def self.down
     change_column :associations, :thirdpartyperson_id, :integer
   end
end
