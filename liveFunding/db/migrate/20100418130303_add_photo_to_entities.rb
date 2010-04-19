class AddPhotoToEntities < ActiveRecord::Migration
  def self.up
     add_column :entities, :photo_file_name, :string
     add_column :entities, :photo_content_type, :string
     add_column :entities, :photo_file_size, :integer
    
  end

  def self.down
      remove_column :entities, :photo_file_name
      remove_column :entities, :photo_content_type
      remove_column :entities, :photo_file_size
  end
end
