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

ActiveRecord::Schema.define(version: 2021_10_31_132049) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookmarks", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.bigint "user_id", null: false
    t.string "comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_bookmarks_on_course_id"
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "buildings_complexes", force: :cascade do |t|
    t.bigint "citie_id", null: false
    t.bigint "institution_id", null: false
    t.string "name"
    t.string "address"
    t.string "website"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["citie_id"], name: "index_buildings_complexes_on_citie_id"
    t.index ["institution_id"], name: "index_buildings_complexes_on_institution_id"
  end

  create_table "cities", force: :cascade do |t|
    t.bigint "state_id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["state_id"], name: "index_cities_on_state_id"
  end

  create_table "courses", force: :cascade do |t|
    t.bigint "buildings_complex_id", null: false
    t.date "opening_date"
    t.string "name"
    t.string "degree"
    t.string "modality"
    t.string "shift"
    t.integer "total_vacancies"
    t.integer "semesters"
    t.integer "hours"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["buildings_complex_id"], name: "index_courses_on_buildings_complex_id"
  end

  create_table "institutions", force: :cascade do |t|
    t.string "name"
    t.string "initials"
    t.string "website"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "states", force: :cascade do |t|
    t.string "name"
    t.string "initials"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.float "ling_score"
    t.float "mat_score"
    t.float "cr_score"
    t.float "cn_score"
    t.float "red_score"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bookmarks", "courses"
  add_foreign_key "bookmarks", "users"
  add_foreign_key "buildings_complexes", "cities", column: "citie_id"
  add_foreign_key "buildings_complexes", "institutions"
  add_foreign_key "cities", "states"
  add_foreign_key "courses", "buildings_complexes"
end
