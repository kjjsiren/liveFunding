class AddEntityIdToTransactions < ActiveRecord::Migration
  def self.up
    add_column :transactions, :entity_id, :integer
  end

  def self.down
    remove_column :transactions, :entity_id, :integer
  end
end
