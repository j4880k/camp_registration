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

ActiveRecord::Schema.define(:version => 20121231141935) do

  create_table "addresses", :force => true do |t|
    t.string   "Street1"
    t.string   "Street2"
    t.string   "Street3"
    t.string   "City"
    t.string   "State"
    t.string   "zipcode"
    t.string   "notes"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "contact_phones", :force => true do |t|
    t.integer  "contact_id"
    t.integer  "phone_id"
    t.string   "notes"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "coupons", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.string   "discount_type"
    t.float    "discount_value"
    t.boolean  "code_mask"
    t.integer  "use_limit"
    t.text     "description"
    t.date     "effective_start_date"
    t.date     "effective_end_date"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "event_id"
  end

  create_table "emails", :force => true do |t|
    t.string   "emailAddress"
    t.string   "nickname"
    t.string   "notes"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "event_resources", :force => true do |t|
    t.integer  "event_id"
    t.integer  "resource_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "events", :force => true do |t|
    t.datetime "date_begin"
    t.datetime "date_end"
    t.float    "price"
    t.text     "notes"
    t.string   "eventname"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "insurances", :force => true do |t|
    t.string   "provider"
    t.string   "employer"
    t.string   "policyNumber"
    t.string   "groupName"
    t.string   "groupNumber"
    t.string   "notes"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.boolean  "is_primary"
  end

  create_table "invoices", :force => true do |t|
    t.integer  "user_id"
    t.string   "reference_code"
    t.text     "items_hash"
    t.string   "payment_type"
    t.date     "payment_date"
    t.boolean  "is_confirmed"
    t.text     "broker_stream"
    t.string   "status"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "user_coupon_code"
  end

  create_table "keywords", :force => true do |t|
    t.string   "listKey"
    t.string   "listValue"
    t.string   "listLabel"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "notes", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.string   "notes"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "people", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "middleinit"
    t.date     "birthdate"
    t.string   "nickname"
    t.string   "gender"
    t.date     "date_created"
    t.string   "password"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "shirtsize"
    t.integer  "user_id"
    t.boolean  "photo_allowed"
    t.boolean  "allow_tylenol"
    t.boolean  "allow_sudafed"
    t.boolean  "allow_ibuprofin"
    t.boolean  "allow_mylanta"
    t.boolean  "allow_cough_medicine"
    t.boolean  "allow_benadryl"
  end

  create_table "people_addresses", :force => true do |t|
    t.integer  "person_id"
    t.integer  "address_id"
    t.integer  "is_primary"
    t.integer  "is_deleted"
    t.string   "notes"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "person_address", :id => false, :force => true do |t|
    t.integer  "person_id"
    t.integer  "address_id"
    t.integer  "is_primary"
    t.integer  "is_deleted"
    t.string   "notes"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "person_addresses", :force => true do |t|
    t.integer  "person_id"
    t.integer  "address_id"
    t.integer  "is_primary"
    t.integer  "is_deleted"
    t.string   "notes"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "person_allergies", :force => true do |t|
    t.integer  "person_id"
    t.string   "allergyname"
    t.string   "notes"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "allergy_type"
  end

  create_table "person_emails", :force => true do |t|
    t.integer  "person_id"
    t.integer  "email_id"
    t.string   "notes"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "person_medical_notes", :force => true do |t|
    t.integer  "person_id"
    t.string   "notes"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "created_by"
  end

  create_table "person_medications", :force => true do |t|
    t.integer  "person_id"
    t.string   "medicationname"
    t.string   "notes"
    t.integer  "isactive"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "medication_type"
  end

  create_table "person_organizations", :force => true do |t|
    t.integer  "organization_id"
    t.integer  "person_id"
    t.string   "notes"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "person_simple_contacts", :force => true do |t|
    t.integer  "person_id"
    t.integer  "simple_contact_id"
    t.string   "notes"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "phones", :force => true do |t|
    t.integer  "phoneNumber"
    t.string   "phoneType"
    t.string   "notes"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "reservation_carts", :force => true do |t|
    t.integer  "reservation_id"
    t.string   "status"
    t.string   "reference_code"
    t.integer  "invoice_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "coupon_id"
  end

  create_table "reservation_resources", :force => true do |t|
    t.integer  "reservation_id"
    t.integer  "resource_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "reservations", :force => true do |t|
    t.integer  "person_id"
    t.integer  "event_id"
    t.boolean  "is_deleted"
    t.boolean  "is_staffing"
    t.text     "notes"
    t.float    "discount"
    t.float    "amountpaid"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.boolean  "locked"
    t.integer  "updated_by"
    t.string   "billing_status"
  end

  create_table "resources", :force => true do |t|
    t.string   "resourcetype"
    t.string   "name"
    t.integer  "occupancy"
    t.text     "notes"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "simple_contact_emails", :force => true do |t|
    t.integer  "simple_contact_id"
    t.string   "emailaddress"
    t.string   "nickname"
    t.string   "notes"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "simple_contact_insurances", :force => true do |t|
    t.integer  "simple_contact_id"
    t.string   "provider"
    t.string   "employer"
    t.string   "policynumber"
    t.string   "groupname"
    t.string   "groupnumber"
    t.string   "notes"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.boolean  "is_primary"
  end

  create_table "simple_contact_phones", :force => true do |t|
    t.integer  "simple_contact_id"
    t.integer  "phone_id"
    t.integer  "scphonenumber"
    t.string   "scphonetype"
    t.string   "notes"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "simple_contacts", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "relationship"
    t.string   "contacttype"
    t.text     "notes"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "user_event_assignments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.string   "assignment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "role"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
