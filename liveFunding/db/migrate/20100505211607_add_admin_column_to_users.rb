class AddAdminColumnToUsers < ActiveRecord::Migration
  def self.up
    change_column :users, :is_admin,:int, :default => 1
  end

  def self.down
    remove_column :users, :is_admin
  end
end
