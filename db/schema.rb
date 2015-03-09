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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150304181113) do

  create_table "conversations", force: true do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "team_id"
    t.integer  "home_team_id"
    t.integer  "visiting_team_id"
  end

  add_index "conversations", ["recipient_id"], name: "index_conversations_on_recipient_id"
  add_index "conversations", ["sender_id"], name: "index_conversations_on_sender_id"

  create_table "messages", force: true do |t|
    t.text     "body"
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id"
  add_index "messages", ["user_id"], name: "index_messages_on_user_id"

  create_table "team_relationships", force: true do |t|
    t.datetime "accepted_at"
    t.datetime "rejected_at"
    t.integer  "sender_team_id"
    t.integer  "receiver_team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "team_relationships", ["receiver_team_id"], name: "index_team_relationships_on_receiver_team_id"
  add_index "team_relationships", ["sender_team_id"], name: "index_team_relationships_on_sender_team_id"

  create_table "teammate_relationships", force: true do |t|
    t.datetime "accepted_at"
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.integer  "team_relationship_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "teammate_relationships", ["receiver_id"], name: "index_teammate_relationships_on_receiver_id"
  add_index "teammate_relationships", ["sender_id"], name: "index_teammate_relationships_on_sender_id"
  add_index "teammate_relationships", ["team_relationship_id"], name: "index_teammate_relationships_on_team_relationship_id"

  create_table "teams", force: true do |t|
    t.string  "name"
    t.string  "sport"
    t.string  "location"
    t.integer "captain_id"
    t.string  "avatar"
    t.integer "home_team_id"
    t.float   "latitude"
    t.float   "longitude"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "type"
    t.integer  "team_id"
    t.string   "role"
    t.text     "bio"
    t.string   "avatar"
    t.integer  "vidconference_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["vidconference_id"], name: "index_users_on_vidconference_id"

  create_table "vidconferences", force: true do |t|
    t.string "session"
  end

end
