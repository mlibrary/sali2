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

ActiveRecord::Schema.define(version: 20180419015711) do

  create_table "session_requests", force: :cascade do |t|
    t.integer "requested_by_id"
    t.integer "contact_person_id"
    t.string "title"
    t.string "state"
    t.integer "expected_attendance"
    t.boolean "course_related"
    t.boolean "library_location_required"
    t.boolean "evaluation_needed"
    t.boolean "registration_needed"
    t.text "notes"
    t.text "accommodations"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_person_id"], name: "index_session_requests_on_contact_person_id"
    t.index ["requested_by_id"], name: "index_session_requests_on_requested_by_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "uniqname"
    t.string "firstname"
    t.string "lastname"
    t.string "role"
    t.string "calendar_url"
    t.string "access_token"
    t.string "refresh_token"
    t.string "records_per_page"
    t.string "unit"
    t.string "crypted_password"
    t.string "salt"
    t.boolean "active"
    t.boolean "notify_new_request"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uniqname"], name: "index_users_on_uniqname"
  end

end
