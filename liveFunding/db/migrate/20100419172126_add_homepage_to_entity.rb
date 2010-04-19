class AddHomepageToEntity < ActiveRecord::Migration
  def self.up
     add_column :entities, :homepage, :string
  end

  def self.down
     add_column :entities, :homepage, :string
  end
end
