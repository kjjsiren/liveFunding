class AddColumnstoAssociations < ActiveRecord::Migration
  def self.up
    add_column :associations, :infosource, :string
  end

  def self.down
    remove_column :associations, :infosource, :string
  end
end
