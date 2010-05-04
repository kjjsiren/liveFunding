class CreateInformationSources < ActiveRecord::Migration
  def self.up
    create_table :information_sources do |t|
      t.string :source
      t.integer :rank
      t.references :transaction
      t.timestamps
    end
  end

  def self.down
    drop_table :information_sources
  end
end
