class ChangecolumntypesinTransactions < ActiveRecord::Migration
  def self.up
     change_column :transactions, :donor, :integer
     change_column :transactions, :recipient, :integer  
   end

   def self.down
     change_column :transactions, :donor, :string
     change_column :transactions, :recipient, :string  
   end
 end
