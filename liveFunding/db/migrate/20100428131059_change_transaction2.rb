class ChangeTransaction2 < ActiveRecord::Migration
  def self.up
    remove_column :transactions, :creator, :integer
    add_column :transactions, :creator_id, :integer
  end
    remove_column :transactions, :creator_id, :integer
  def self.down
  end
end
