# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130319201755) do

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.integer  "state_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "cities", ["state_id"], :name => "index_cities_on_state_id"

  create_table "clinics", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.integer  "city_id"
    t.string   "address_neighbourhood"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "clinics", ["city_id"], :name => "index_clinics_on_city_id"

  create_table "companies", :force => true do |t|
    t.string   "legal_identifier"
    t.string   "legal_name"
    t.string   "trade_name"
    t.string   "contact_email"
    t.string   "contact_phone"
    t.string   "contact_name"
    t.string   "address"
    t.integer  "city_id"
    t.string   "address_neighbourhood"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "companies", ["city_id"], :name => "index_companies_on_city_id"

  create_table "donors", :force => true do |t|
    t.string   "name"
    t.string   "legal_identifier"
    t.string   "document_type"
    t.datetime "birth_date"
    t.string   "role"
    t.integer  "company_id"
    t.string   "gender"
    t.boolean  "uses_medication"
    t.string   "uses_medication_description"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "donors", ["company_id"], :name => "index_donors_on_company_id"

  create_table "drug_tests", :force => true do |t|
    t.datetime "scheduled_to"
    t.integer  "donor_id"
    t.integer  "selection_id"
    t.string   "notes"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "drug_tests", ["donor_id"], :name => "index_drug_tests_on_donor_id"
  add_index "drug_tests", ["selection_id"], :name => "index_drug_tests_on_selection_id"

  create_table "selected_tests", :force => true do |t|
    t.integer  "drug_test_id"
    t.integer  "test_type_id"
    t.string   "result"
    t.datetime "completed_at"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "selected_tests", ["drug_test_id"], :name => "index_selected_tests_on_drug_test_id"
  add_index "selected_tests", ["test_type_id"], :name => "index_selected_tests_on_test_type_id"

  create_table "selections", :force => true do |t|
    t.string   "name"
    t.string   "criteria"
    t.string   "exame_responsible"
    t.string   "selection_responsible"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "states", :force => true do |t|
    t.string   "symbol"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "test_types", :force => true do |t|
    t.string   "name"
    t.string   "short_name"
    t.string   "description"
    t.string   "collected_material"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "users", :force => true do |t|
    t.integer  "company_id"
    t.string   "name"
    t.boolean  "remember_me"
    t.string   "role"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "admin",                  :default => false
  end

  add_index "users", ["company_id"], :name => "index_users_on_company_id"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
