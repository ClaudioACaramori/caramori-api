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

ActiveRecord::Schema.define(version: 2018_07_04_211245) do

  create_table "jera_push_devices", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "token"
    t.string "platform"
    t.string "pushable_type"
    t.bigint "pushable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["platform"], name: "index_jera_push_devices_on_platform"
    t.index ["pushable_type", "pushable_id"], name: "index_jera_push_devices_on_pushable_type_and_pushable_id"
    t.index ["token", "platform"], name: "index_jera_push_devices_on_token_and_platform", unique: true
    t.index ["token"], name: "index_jera_push_devices_on_token"
  end

  create_table "jera_push_messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "content"
    t.text "broadcast_result"
    t.string "status"
    t.string "kind"
    t.string "topic"
    t.string "firebase_id"
    t.string "error_message"
    t.integer "failure_count", default: 0
    t.integer "success_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jera_push_messages_devices", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "device_id"
    t.integer "message_id"
    t.string "status"
    t.string "error_message"
    t.string "firebase_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["device_id", "message_id"], name: "jera_push_index_messages_id_devices_id", unique: true
    t.index ["device_id"], name: "index_jera_push_messages_devices_on_device_id"
    t.index ["message_id"], name: "index_jera_push_messages_devices_on_message_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "authentication_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
