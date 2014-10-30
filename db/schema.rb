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

ActiveRecord::Schema.define(:version => 20110412014815) do

  create_table "active_answers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "answer_id"
    t.integer  "active_test_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "question_id"
  end

  create_table "active_tests", :force => true do |t|
    t.integer  "test_id",                       :null => false
    t.integer  "user_id",                       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "start_time"
    t.boolean  "is_running", :default => false
    t.integer  "group_id",                      :null => false
  end

  create_table "answers", :force => true do |t|
    t.integer  "question_id"
    t.text     "tekst",        :null => false
    t.integer  "file_info_id"
    t.integer  "points",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ord_id"
  end

  create_table "bdrb_job_queues", :force => true do |t|
    t.text     "args"
    t.string   "worker_name"
    t.string   "worker_method"
    t.string   "job_key"
    t.integer  "taken"
    t.integer  "finished"
    t.integer  "timeout"
    t.integer  "priority"
    t.datetime "submitted_at"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.datetime "archived_at"
    t.string   "tag"
    t.string   "submitter_info"
    t.string   "runner_info"
    t.string   "worker_key"
    t.datetime "scheduled_at"
  end

  create_table "file_contents", :force => true do |t|
    t.binary   "content",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "file_info_id"
  end

  create_table "file_infos", :force => true do |t|
    t.string   "name",            :null => false
    t.string   "ext",             :null => false
    t.integer  "file_content_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "owner_type"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.integer  "test_id"
  end

  create_table "groups", :force => true do |t|
    t.string   "name",       :limit => 50, :null => false
    t.integer  "year_nr",                  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "ownerships", :force => true do |t|
    t.integer "item_id", :null => false
    t.integer "user_id", :null => false
    t.string  "type"
  end

  add_index "ownerships", ["user_id", "item_id", "type"], :name => "index_ownerships_on_user_id_and_item_id_and_type", :unique => true

  create_table "participants", :force => true do |t|
    t.integer  "active_test_id", :null => false
    t.integer  "user_id",        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "question_types", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", :force => true do |t|
    t.integer  "test_id"
    t.text     "tekst",            :null => false
    t.integer  "file_info_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "question_type_id"
    t.integer  "ord_id"
  end

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "roles_users", ["role_id"], :name => "index_roles_users_on_role_id"
  add_index "roles_users", ["user_id"], :name => "index_roles_users_on_user_id"

  create_table "taken_answers", :force => true do |t|
    t.integer  "answer_id",     :null => false
    t.integer  "user_id",       :null => false
    t.integer  "taken_test_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taken_tests", :force => true do |t|
    t.integer  "test_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
    t.integer  "owner_id"
  end

  create_table "taken_tests_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "taken_test_id"
  end

  create_table "test_groups", :force => true do |t|
    t.string   "name",       :limit => 50, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "tests", :force => true do |t|
    t.integer  "user_id"
    t.string   "name",          :limit => 100, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "test_group_id"
    t.integer  "duration",                     :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "name",                                    :default => "---"
    t.string   "surname",                                 :default => "---"
    t.integer  "index_nr",                                :default => 0
    t.integer  "group_id"
    t.integer  "user_id"
  end

end
