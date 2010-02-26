class RenamecolumnsTransaction < ActiveRecord::Migration
  def self.up
    rename_column :transactions, :from, :donor
    rename_column :transactions, :to, :recipient  
  end

  def self.down
    rename_column :transactions, :donor, :from
    rename_column :transactions, :recipient, :to  
  end
end
