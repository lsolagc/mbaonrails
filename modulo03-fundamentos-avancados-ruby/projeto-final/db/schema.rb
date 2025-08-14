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

ActiveRecord::Schema[8.0].define(version: 2025_08_13_194830) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "combatants", force: :cascade do |t|
    t.integer "armor_class", default: 10, null: false
    t.integer "strength", default: 10, null: false
    t.integer "dexterity", default: 10, null: false
    t.integer "constitution", default: 10, null: false
    t.integer "intelligence", default: 10, null: false
    t.integer "wisdom", default: 10, null: false
    t.integer "charisma", default: 10, null: false
    t.integer "max_hitpoints", default: 10, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "combatable_type", null: false
    t.bigint "combatable_id", null: false
    t.index ["combatable_type", "combatable_id"], name: "index_combatants_on_combatable"
  end

  create_table "player_characters", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
