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

ActiveRecord::Schema.define(version: 2018_12_29_164446) do

  create_table "card_decks", force: :cascade do |t|
    t.integer "card_id"
    t.integer "deck_id"
  end

  create_table "cards", force: :cascade do |t|
    t.string "name"
    t.string "mana_cost"
    t.string "type"
    t.string "power_toughness"
    t.string "rarity"
    t.string "expansion"
    t.string "card_text"
  end

  create_table "decks", force: :cascade do |t|
    t.string "name"
    t.integer "size"
    t.string "color"
    t.integer "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
  end

end