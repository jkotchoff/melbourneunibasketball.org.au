# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130206053035) do

  create_table "members", :force => true do |t|
    t.string   "eligibility_clause"
    t.string   "eligibility_justification"
    t.string   "payment_method"
    t.boolean  "representative_player",              :default => false
    t.integer  "year"
    t.string   "given_name"
    t.string   "family_name"
    t.string   "postal_address"
    t.integer  "postcode"
    t.string   "phone_number_mobile"
    t.string   "phone_number_other"
    t.string   "email"
    t.datetime "date_of_birth"
    t.string   "gender"
    t.boolean  "new_member",                         :default => true
    t.string   "your_existing_mubc_singlet_numbers"
    t.text     "how_did_you_hear_about_the_club"
    t.integer  "amount_paid"
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
  end

  create_table "pages", :force => true do |t|
    t.string   "type"
    t.string   "title"
    t.string   "author"
    t.text     "synopsis"
    t.text     "content"
    t.string   "image"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
