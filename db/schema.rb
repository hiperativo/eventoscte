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

ActiveRecord::Schema.define(:version => 20130408014011) do

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "enrollments", :force => true do |t|
    t.string   "full_name"
    t.string   "display_name"
    t.string   "email"
    t.string   "category"
    t.string   "profession"
    t.string   "occupation"
    t.string   "enterprise"
    t.string   "cnpj"
    t.string   "cep"
    t.string   "address"
    t.string   "complement"
    t.string   "number"
    t.string   "neighbourhood"
    t.string   "city"
    t.string   "state"
    t.string   "phone"
    t.string   "receipt_person"
    t.boolean  "active_cte_client"
    t.string   "how_did_you_knew_us"
    t.boolean  "want_to_receive_newsletter"
    t.string   "entity"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "state_register"
    t.integer  "event_id"
    t.string   "receipt_or_nf"
    t.string   "cpf"
    t.text     "itau_crypto"
    t.string   "payment_type"
    t.string   "price"
  end

  create_table "events", :force => true do |t|
    t.string   "title"
    t.string   "lead"
    t.string   "banner"
    t.text     "description"
    t.datetime "date"
    t.string   "place"
    t.string   "address"
    t.text     "target"
    t.string   "contact_info"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.text     "before"
    t.text     "after"
    t.boolean  "disabled",     :default => false
    t.string   "slug"
  end

  create_table "interviews", :force => true do |t|
    t.string   "title"
    t.string   "lead"
    t.string   "synopsis"
    t.string   "image"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "contents"
  end

  create_table "panels", :force => true do |t|
    t.integer  "event_id"
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "ordem"
  end

  create_table "projects", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "synopsis"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month"
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "sliders", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.string   "image"
    t.string   "link"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "speakers", :force => true do |t|
    t.string   "name"
    t.string   "ocupation"
    t.text     "bio"
    t.string   "avatar"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "supporters", :force => true do |t|
    t.string   "image"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
  end

  create_table "talks", :force => true do |t|
    t.string   "title"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "panel_id"
    t.integer  "speaker_id"
    t.text     "additional_info"
    t.time     "starts_at"
    t.text     "after"
  end

end
