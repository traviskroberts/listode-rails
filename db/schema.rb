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

ActiveRecord::Schema.define(:version => 20091025184754) do

  create_table "lists", :force => true do |t|
    t.integer  "task_id"
    t.integer  "month_list_id"
    t.boolean  "complete",      :default => false
    t.float    "amount"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lists", ["month_list_id"], :name => "index_lists_on_month_list_id"
  add_index "lists", ["task_id"], :name => "index_lists_on_task_id"

  create_table "month_lists", :force => true do |t|
    t.integer  "user_id"
    t.integer  "month"
    t.integer  "year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "task_groups", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "task_groups", ["user_id"], :name => "index_task_groups_on_user_id"

  create_table "tasks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "task_group_id"
    t.string   "title"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tasks", ["task_group_id"], :name => "index_tasks_on_task_group_id"
  add_index "tasks", ["user_id"], :name => "index_tasks_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.date     "member_since"
    t.boolean  "admin",             :default => false
    t.boolean  "task_reminder",     :default => true
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
