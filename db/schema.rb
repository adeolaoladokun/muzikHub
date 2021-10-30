# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_10_26_130642) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", id: false, force: :cascade do |t|
    t.serial "account_id", null: false
    t.text "business_name"
    t.string "account_number"
    t.decimal "percentage_charge"
    t.string "settlement_bank"
    t.string "subaccount_code"
    t.boolean "is_verified"
    t.boolean "active"
    t.datetime "createdat"
    t.datetime "updatedat"
    t.integer "user_id"
    t.string "currency"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "role_id", null: false
  end

  create_table "songs", primary_key: "song_id", id: :integer, default: -> { "nextval('songs_account_id_seq'::regclass)" }, force: :cascade do |t|
    t.text "artist"
    t.string "label"
    t.string "title"
    t.string "category"
    t.decimal "price"
    t.boolean "active"
    t.datetime "createdat"
    t.datetime "updatedat"
    t.integer "user_id"
  end

  create_table "transactions", id: :serial, force: :cascade do |t|
    t.text "trxn_reference"
    t.decimal "amount"
    t.decimal "platform_amount"
    t.date "payment_date"
    t.integer "song_id"
    t.integer "user_id"
    t.string "status"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "superadmin_role", default: false
    t.boolean "creator_role", default: false
    t.boolean "fan_role", default: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "views", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_views_on_email", unique: true
    t.index ["reset_password_token"], name: "index_views_on_reset_password_token", unique: true
  end

  add_foreign_key "accounts", "users", name: "accounts_user_id_fkey"
  add_foreign_key "songs", "users", name: "songs_user_id_fkey"
  add_foreign_key "transactions", "songs", primary_key: "song_id", name: "transactions_song_id_fkey"
  add_foreign_key "transactions", "users", name: "transactions_user_id_fkey"
end
