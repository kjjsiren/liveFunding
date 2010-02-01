class CreateTransactions < ActiveRecord::Migration
  def self.up
    create_table :transactions do |t|
      t.integer :amount
      t.string :to
      t.string :from

      t.timestamps
    end
  end

  def self.down
    drop_table :transactions
  end
end
