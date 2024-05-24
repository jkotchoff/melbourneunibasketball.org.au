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

ActiveRecord::Schema.define(version: 2024_08_14_120146) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "content_images", id: :serial, force: :cascade do |t|
    t.integer "page_id"
    t.string "image", limit: 255
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
    t.string "locked_by", limit: 255
    t.string "queue", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "members", id: :serial, force: :cascade do |t|
    t.string "eligibility_clause", limit: 255
    t.string "eligibility_justification", limit: 255
    t.string "payment_method", limit: 255
    t.string "paypal_payer_id", limit: 255
    t.string "paypal_token", limit: 255
    t.string "given_name", limit: 255
    t.string "family_name", limit: 255
    t.string "postal_address", limit: 255
    t.string "phone_number_mobile", limit: 255
    t.string "phone_number_other", limit: 255
    t.string "email", limit: 255
    t.date "date_of_birth"
    t.string "gender", limit: 255
    t.boolean "new_member", default: true
    t.string "your_existing_mubc_singlet_numbers", limit: 255
    t.text "how_did_you_hear_about_the_club"
    t.integer "amount_paid"
    t.boolean "payment_confirmed", default: false
    t.string "payment_acknowledgement", limit: 255
    t.string "photo", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "photo_processing"
    t.boolean "international_student", default: false
    t.string "availability", limit: 255
    t.string "stripe_customer_id", limit: 255
  end

  create_table "pages", id: :serial, force: :cascade do |t|
    t.string "type", limit: 255
    t.string "title", limit: 255
    t.string "author", limit: 255
    t.text "synopsis"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "pdf", limit: 255
    t.string "slug", limit: 255
    t.boolean "sticky"
    t.string "dribbling_balls_link", limit: 255
    t.string "newsletter"
    t.index ["slug"], name: "index_pages_on_slug", unique: true
    t.index ["sticky"], name: "index_pages_on_sticky"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
