class RemoveThirdpartypeople < ActiveRecord::Migration
  def self.up
  	drop_table :thirdpartypeople
  end

  def self.down
  	  create_table :thirdpartypeople do |t|
      t.string :last_name
      t.string :first_name
      t.string :sex
      t.string :phone_number
      t.date :birthday

      t.timestamps
    end
  end
end
