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

ActiveRecord::Schema.define(version: 2017_09_17_033544) do

  create_table "content_images", id: :serial, force: :cascade do |t|
    t.integer "page_id"
    t.string "image"
    t.date "created_at"
  end

  create_table "delayed_jobs", id: :serial, force: :cascade do |t|
    t.integer "priority", default: 0
    t.integer "attempts", default: 0
    t.text "handler"
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "members", id: :serial, force: :cascade do |t|
    t.string "eligibility_clause"
    t.string "eligibility_justification"
    t.string "payment_method"
    t.string "paypal_payer_id"
    t.string "paypal_token"
    t.string "given_name"
    t.string "family_name"
    t.string "postal_address"
    t.string "phone_number_mobile"
    t.string "phone_number_other"
    t.string "email"
    t.date "date_of_birth"
    t.string "gender"
    t.boolean "new_member", default: true
    t.string "your_existing_mubc_singlet_numbers"
    t.text "how_did_you_hear_about_the_club"
    t.integer "amount_paid"
    t.boolean "payment_confirmed", default: false
    t.string "payment_acknowledgement"
    t.string "photo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "photo_processing"
    t.boolean "international_student", default: false
    t.string "availability"
    t.string "stripe_customer_id"
  end

  create_table "pages", id: :serial, force: :cascade do |t|
    t.string "type"
    t.string "title"
    t.string "author"
    t.text "synopsis"
    t.text "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "pdf"
    t.string "slug"
    t.boolean "sticky"
    t.string "dribbling_balls_link"
    t.index ["slug"], name: "index_pages_on_slug", unique: true
    t.index ["sticky"], name: "index_pages_on_sticky"
  end

end
