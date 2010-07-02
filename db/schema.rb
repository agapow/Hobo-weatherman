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

ActiveRecord::Schema.define(:version => 20100701112620) do

  create_table "bioseqcollection_biosequences", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "biosequence_id"
    t.integer  "bioseqcollection_id"
  end

  add_index "bioseqcollection_biosequences", ["bioseqcollection_id"], :name => "index_bioseqcollection_biosequences_on_bioseqcollection_id"
  add_index "bioseqcollection_biosequences", ["biosequence_id"], :name => "index_bioseqcollection_biosequences_on_biosequence_id"

  create_table "bioseqcollections", :force => true do |t|
    t.string   "identifier"
    t.string   "source"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bioseqfeatures", :force => true do |t|
    t.string  "name",           :limit => 64
    t.string  "value"
    t.integer "start"
    t.integer "stop"
    t.integer "biosequence_id"
  end

  add_index "bioseqfeatures", ["biosequence_id"], :name => "index_bioseqfeatures_on_biosequence_id"

  create_table "biosequences", :force => true do |t|
    t.string   "identifier",  :limit => 32
    t.string   "source",      :limit => 32
    t.string   "title",       :limit => 64
    t.text     "description"
    t.text     "seqdata"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.string   "company"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.date     "date_met"
    t.boolean  "married"
    t.integer  "age"
    t.text     "notes"
  end

  create_table "isolatecollection_isolates", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "isolate_id"
    t.integer  "isolatecollection_id"
  end

  add_index "isolatecollection_isolates", ["isolate_id"], :name => "index_isolatecollection_isolates_on_isolate_id"
  add_index "isolatecollection_isolates", ["isolatecollection_id"], :name => "index_isolatecollection_isolates_on_isolatecollection_id"

  create_table "isolatecollections", :force => true do |t|
    t.string   "identifier"
    t.string   "source"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "isolates", :force => true do |t|
    t.string   "identifier"
    t.string   "source"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "serotype"
    t.string   "host"
    t.string   "country"
    t.string   "region"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "name"
    t.string   "email_address"
    t.boolean  "administrator",                           :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",                                   :default => "active"
    t.datetime "key_timestamp"
  end

  add_index "users", ["state"], :name => "index_users_on_state"

end
