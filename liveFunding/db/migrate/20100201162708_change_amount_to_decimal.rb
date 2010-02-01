class ChangeAmountToDecimal < ActiveRecord::Migration
  def self.up
    change_column :transactions, :amount, :decimal, :null => false
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
