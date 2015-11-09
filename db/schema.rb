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

ActiveRecord::Schema.define(:version => 20151029183127) do

  create_table "admins", :force => true do |t|
    t.string   "displayName"
    t.string   "netid"
    t.string   "dukeId"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "lti_dockers", :force => true do |t|
    t.text     "host"
    t.integer  "port"
    t.string   "pw"
    t.string   "appname"
    t.text     "appdesc"
    t.boolean  "expired"
    t.string   "username"
    t.string   "userId"
    t.string   "userEmail"
    t.string   "string"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "lti_nonces", :force => true do |t|
    t.string   "nonce"
    t.string   "userId"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "lti_user_sessions", :force => true do |t|
    t.string   "username"
    t.string   "userId"
    t.string   "userEmail"
    t.string   "destination"
    t.string   "action"
    t.string   "notes"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

end
