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

ActiveRecord::Schema.define(version: 2022_05_11_130947) do

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.string "unit"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reports", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "item_id", null: false
    t.string "process"
    t.integer "process_number"
    t.date "day"
    t.string "purpose"
    t.integer "confirmer"
    t.string "confirmation"
    t.string "boolean"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_id"], name: "index_reports_on_item_id"
    t.index ["user_id"], name: "index_reports_on_user_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.integer "number"
    t.integer "item_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_id"], name: "index_stocks_on_item_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.integer "number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "reports", "items"
  add_foreign_key "reports", "users"
  add_foreign_key "stocks", "items"
end
