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

ActiveRecord::Schema.define(:version => 20100422034251) do

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.integer  "account_id"
    t.integer  "department_head_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizational_roles", :force => true do |t|
    t.string   "name",                                    :null => false
    t.integer  "account_id"
    t.integer  "department_id"
    t.string   "role_description",         :limit => 500
    t.string   "ancestry"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "organizational_unit_type"
  end

  add_index "organizational_roles", ["ancestry"], :name => "index_organizational_roles_on_ancestry"

  create_table "organizational_units", :force => true do |t|
    t.string   "name"
    t.string   "type"
    t.integer  "account_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ancestry"
  end

  add_index "organizational_units", ["ancestry"], :name => "index_organizational_units_on_ancestry"

  create_table "people", :force => true do |t|
    t.integer  "account_id",     :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_initial"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email_address"
    t.datetime "last_access"
    t.string   "type"
  end

  create_table "requirements", :force => true do |t|
    t.integer  "account_id", :null => false
    t.string   "type"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
