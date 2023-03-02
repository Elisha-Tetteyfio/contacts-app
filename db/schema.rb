# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_03_02_152407) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.bigint "region_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["region_id"], name: "index_cities_on_region_id"
    t.index ["user_id"], name: "index_cities_on_user_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "fname"
    t.string "lname"
    t.string "phone"
    t.date "birth_date"
    t.string "email"
    t.bigint "user_id", null: false
    t.bigint "suburb_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["suburb_id"], name: "index_contacts_on_suburb_id"
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "permissions", force: :cascade do |t|
    t.string "subject_class"
    t.string "action"
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "regions", force: :cascade do |t|
    t.string "name"
    t.text "remark"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_regions_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "role_code"
    t.boolean "active_status", default: true
    t.boolean "del_status", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "suburbs", force: :cascade do |t|
    t.string "name"
    t.bigint "city_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_suburbs_on_city_id"
    t.index ["user_id"], name: "index_suburbs_on_user_id"
  end

  create_table "user_roles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "role_id", null: false
    t.string "role_code"
    t.boolean "active_status", default: true
    t.boolean "del_status", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_user_roles_on_role_id"
    t.index ["user_id"], name: "index_user_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "fname"
    t.string "lname"
    t.string "phone"
    t.date "birth_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "cities", "regions"
  add_foreign_key "cities", "users"
  add_foreign_key "contacts", "suburbs"
  add_foreign_key "contacts", "users"
  add_foreign_key "regions", "users"
  add_foreign_key "suburbs", "cities"
  add_foreign_key "suburbs", "users"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
end
