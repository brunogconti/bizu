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
    t.bigint "user_id", null: false
    t.bigint "course_id", null: false
    t.string "comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_bookmarks_on_course_id"
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.string "state"
    t.text "abstract"
    t.integer "population"
    t.float "idh"
    t.float "max_temp_avg"
    t.float "min_temp_avg"
    t.float "rain_days"
    t.float "daylight_hours"
    t.float "bus_cost"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "courses", force: :cascade do |t|
    t.bigint "unit_id", null: false
    t.string "opening_date"
    t.string "name"
    t.text "abstract"
    t.string "degree"
    t.string "shift"
    t.string "periodization"
    t.integer "periodization_num"
    t.integer "vacancies"
    t.integer "hours"
    t.string "website"
    t.string "instagram"
    t.integer "enade"
    t.integer "cpc"
    t.integer "cc"
    t.integer "idd"
    t.float "weight_lin"
    t.float "weight_mat"
    t.float "weight_ch"
    t.float "weight_cn"
    t.float "weight_red"
    t.float "min_lin"
    t.float "min_mat"
    t.float "min_ch"
    t.float "min_cn"
    t.float "min_red"
    t.float "min_geral"
    t.float "bonus"
    t.string "bonus_comment"
    t.integer "api_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["unit_id"], name: "index_courses_on_unit_id"
  end

  create_table "institutions", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.string "initials"
    t.string "foundation"
    t.string "website"
    t.string "instagram"
    t.text "abstract"
    t.integer "total_students"
    t.integer "ci"
    t.integer "igc"
    t.integer "igc_c"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "course_id", null: false
    t.integer "rating"
    t.string "comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_reviews_on_course_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "segments", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.string "name"
    t.string "sisu_edition"
    t.float "score"
    t.integer "vacancies"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_segments_on_course_id"
  end

  create_table "units", force: :cascade do |t|
    t.bigint "citie_id", null: false
    t.bigint "institution_id", null: false
    t.string "name"
    t.string "slug"
    t.string "slug_uni"
    t.string "address"
    t.string "website"
    t.string "instagram"
    t.text "abstract"
    t.boolean "internet"
    t.boolean "restaurant"
    t.boolean "accomodation"
    t.boolean "transport"
    t.boolean "sports_playground"
    t.float "xerox_cost"
    t.float "snack_plus_drink_price"
    t.float "coffe_price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["citie_id"], name: "index_units_on_citie_id"
    t.index ["institution_id"], name: "index_units_on_institution_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "user_type"
    t.string "name"
    t.string "address"
    t.string "course"
    t.string "unit"
    t.string "institution"
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
  add_foreign_key "courses", "units"
  add_foreign_key "reviews", "courses"
  add_foreign_key "reviews", "users"
  add_foreign_key "segments", "courses"
  add_foreign_key "units", "cities", column: "citie_id"
  add_foreign_key "units", "institutions"
end
