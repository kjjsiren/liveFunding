# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100322173128) do

  create_table "associations", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "entity_id"
    t.string   "knows_entity_id"
    t.string   "infosource"
    t.string   "description"
  end

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "transaction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "commenter"
  end

  create_table "entities", :force => true do |t|
    t.boolean  "is_organization"
    t.string   "name"
    t.string   "leader"
    t.string   "email"
    t.string   "phone_number"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "thirdpartypeople", :force => true do |t|
    t.string   "last_name"
    t.string   "first_name"
    t.string   "sex"
    t.string   "phone_number"
    t.date     "birthday"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", :force => true do |t|
    t.decimal  "amount"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "recipient_id"
    t.string   "donor_id"
    t.integer  "rank"
    t.integer  "entity_id"
    t.integer  "ilike"
  end

  create_table "transactions_users", :id => false, :force => true do |t|
    t.integer "transaction_id"
    t.integer "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.string   "phone_number"
    t.string   "hashed_password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "link"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
  end

end
