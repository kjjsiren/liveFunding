class AddDateOfTransactionToTransaction < ActiveRecord::Migration
  def self.up
    add_column :transactions, :date_of_transaction, :date
  end

  def self.down
    remove_column :transactions, :date_of_transaction
  end
end
