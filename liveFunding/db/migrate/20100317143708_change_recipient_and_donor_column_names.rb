class ChangeRecipientAndDonorColumnNames < ActiveRecord::Migration
  def self.up
     rename_column :transactions, :donor, :donor_id
     rename_column :transactions, :recipient, :recipient_id  
   end

   def self.down
     rename_column :transactions, :donor_id, :donor
     rename_column :transactions, :recipient_id, :recipient  
   end
end
