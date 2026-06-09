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

ActiveRecord::Schema[8.1].define(version: 2026_06_09_113401) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "posts", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.text "perex"
    t.datetime "published_at"
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["published_at"], name: "index_posts_on_published_at"
  end

  create_table "work_experiences", force: :cascade do |t|
    t.string "company"
    t.datetime "created_at", null: false
    t.date "ended_on"
    t.string "logo"
    t.string "role"
    t.date "started_on"
    t.datetime "updated_at", null: false
  end
end
