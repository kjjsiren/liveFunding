class AddColumnsToTransactions < ActiveRecord::Migration
  def self.up
  add_column :transactions, :to, :string
  add_column :transactions, :from, :string
  add_column :transactions, :rank, :integer
  end

  def self.down
  remove_column :transactions, :to, :string
  remove_column :transactions, :from, :string
  remove_column :transactions, :rank, :integer
  
  end
end
