class AddCommenterToComment < ActiveRecord::Migration
  def self.up
    add_column :comments, :commenter, :string
  end

  def self.down
    remove_column :comments, :commenter
  end
end
