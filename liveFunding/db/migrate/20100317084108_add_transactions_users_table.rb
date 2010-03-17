class AddTransactionsUsersTable < ActiveRecord::Migration
  def self.up
    create_table :transactions_users, :id => false do |t|
          t.references :transaction
          t.references :user
        end
    
  end

  def self.down
    drop_table :transactions_users
  end
end
