class CreateThirdpartypeople < ActiveRecord::Migration
  def self.up
    create_table :thirdpartypeople do |t|
      t.string :last_name
      t.string :first_name
      t.string :sex
      t.string :phone_number
      t.date :birthday

      t.timestamps
    end
  end

  def self.down
    drop_table :thirdpartypeople
  end
end
