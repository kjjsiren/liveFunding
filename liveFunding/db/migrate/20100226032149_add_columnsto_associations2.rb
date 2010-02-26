class AddColumnstoAssociations2 < ActiveRecord::Migration
  def self.up
    add_column :associations, :description, :string
  end

  def self.down
    remove_column :associations, :description, :string
  end
end
