class CreateEntities < ActiveRecord::Migration
  def self.up
  	drop_table :organizations
    create_table :entities do |t|
      t.boolean :is_organization
      t.string :name
      t.string :leader
      t.string :email
      t.string :phone_number
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :entities
    create_table :organizations do |t|
			t.string :name
			t.string :email
			t.string :phone_number
			t.text :description
			t.boolean :iforganization

			t.timestamps
    end
  end
end
