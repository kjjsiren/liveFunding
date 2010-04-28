class ChangeTransaction < ActiveRecord::Migration
  def self.up
    remove_column :transactions, :user_id, :integer
    add_column :transactions, :creator, :integer
  end

  def self.down
    remove_column :transactions, :creator, :integer
  end
end
