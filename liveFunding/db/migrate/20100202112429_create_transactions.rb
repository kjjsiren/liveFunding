class CreateTransactions < ActiveRecord::Migration
  def self.up
	drop_table :transactions
  end

  def self.down
    drop_table :transactions
  end
end
