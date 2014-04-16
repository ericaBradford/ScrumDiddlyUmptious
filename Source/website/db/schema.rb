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

ActiveRecord::Schema.define(version: 20140416222551) do

  create_table "foods", force: true do |t|
    t.string   "foodName"
    t.text     "description"
    t.boolean  "isDairyFree"
    t.boolean  "isEggFree"
    t.boolean  "isFishFree"
    t.boolean  "isMeatFree"
    t.boolean  "isShellfishFree"
    t.boolean  "isGlutenFree"
    t.boolean  "isHighFiber"
    t.boolean  "isSugarFree"
    t.boolean  "isPeanutFree"
    t.boolean  "isTreeNutFree"
    t.boolean  "isWheatFree"
    t.boolean  "isSoyFree"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recipes", force: true do |t|
    t.string   "title"
    t.text     "directions"
    t.decimal  "cookTime",          precision: 4, scale: 2
    t.decimal  "costOfIngredients", precision: 6, scale: 2
    t.boolean  "canPrepareAhead"
    t.integer  "id_Users"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recipes_ingredients", force: true do |t|
    t.integer  "id_Recipes"
    t.integer  "id_Foods"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "userName"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users_favorites", force: true do |t|
    t.integer  "id_Users"
    t.integer  "id_Recipes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users_preferences", force: true do |t|
    t.integer  "id_Foods"
    t.integer  "id_Users"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users_ratings", force: true do |t|
    t.integer  "id_Users"
    t.integer  "id_Recipes"
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
