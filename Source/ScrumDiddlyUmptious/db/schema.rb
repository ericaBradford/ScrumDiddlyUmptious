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

ActiveRecord::Schema.define(version: 20140502001138) do

  create_table "preferences", force: true do |t|
    t.integer "id_Users"
    t.string  "foodsToFilter"
    t.boolean "isPescatarian"
    t.boolean "isVegetarian"
    t.boolean "isVegan"
    t.boolean "isDiabetic"
    t.boolean "noAlcohol"
    t.boolean "isAllergicGluten"
    t.boolean "isAllergicPeanuts"
    t.boolean "isAllergicTreenuts"
    t.boolean "isAllergicDairy"
    t.boolean "isAllergicEggs"
    t.boolean "isAllergicWheat"
    t.boolean "isAllergicSoy"
    t.boolean "isAllergicFish"
    t.boolean "isAllergicShellfish"
    t.boolean "isAsianVegetarian"
    t.boolean "isHindu"
    t.boolean "isMuslim"
    t.boolean "isJain"
    t.boolean "isKosher"
  end

  create_table "recipes", force: true do |t|
    t.string   "title"
    t.text     "directions"
    t.string   "cookTime",          limit: 32
    t.binary   "canPrepareAhead"
    t.integer  "id_Users"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "costOfIngredients",            precision: 6, scale: 2
    t.text     "ingredients"
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "role"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
