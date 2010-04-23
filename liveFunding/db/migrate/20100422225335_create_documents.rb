class CreateDocuments < ActiveRecord::Migration
  def self.up
    create_table :documents do |t|
      t.integer :entity_id
      t.string :document_name
      t.timestamps
    end
  end

  def self.down
    drop_table :documents
  end
end
