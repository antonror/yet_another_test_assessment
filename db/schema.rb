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

ActiveRecord::Schema[7.0].define(version: 2022_03_08_172456) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "offsets", force: :cascade do |t|
    t.decimal "value", precision: 2, scale: 1
  end

  create_table "temperatures", force: :cascade do |t|
    t.decimal "value", precision: 3, scale: 1
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_temperatures_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", limit: 320
  end

  add_foreign_key "temperatures", "users"
end
