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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150127113824) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "biddings", force: true do |t|
    t.integer  "user_id"
    t.integer  "country_id"
    t.integer  "marketingtype_id"
    t.integer  "company_id"
    t.string   "name"
    t.string   "service_url"
    t.text     "detail"
    t.integer  "budget"
    t.datetime "deadline"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "billings", force: true do |t|
    t.integer  "user_id"
    t.integer  "status",                     default: 0
    t.datetime "date"
    t.string   "detail"
    t.integer  "payment_method", limit: 255
    t.float    "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "coutry_id"
    t.integer  "company_id"
  end

  create_table "carts", force: true do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comclients", force: true do |t|
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  create_table "comdocuments", force: true do |t|
    t.integer  "comlang_id"
    t.string   "name"
    t.string   "saved_name"
    t.text     "original_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comlangs", force: true do |t|
    t.integer  "language_id"
    t.integer  "company_id"
    t.string   "name"
    t.text     "introduction"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", force: true do |t|
    t.integer  "num_employee"
    t.integer  "country_id"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.float    "credit"
  end

  create_table "contacts", force: true do |t|
    t.integer  "contact_type"
    t.string   "name"
    t.string   "company_name"
    t.string   "email"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "costs", force: true do |t|
    t.integer  "product_id"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "price",      precision: 8, scale: 2
    t.float    "money"
  end

  create_table "countries", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "searchings_count", default: 0, null: false
    t.integer  "procons_count",    default: 0, null: false
    t.integer  "companies_count",  default: 0, null: false
  end

  create_table "detailangs", force: true do |t|
    t.integer  "detail_id"
    t.integer  "prolang_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "details", force: true do |t|
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "identities", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id"

  create_table "invoices", force: true do |t|
    t.integer  "billing_id"
    t.integer  "invoice_number"
    t.string   "receiver"
    t.string   "email"
    t.text     "description"
    t.string   "price"
    t.string   "payment_method"
    t.string   "order_number"
    t.string   "bank_name"
    t.string   "bank_swift_code"
    t.text     "bank_addredd"
    t.string   "beneficiary_name"
    t.string   "iban"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "bank_address"
  end

  create_table "languages", force: true do |t|
    t.string   "name"
    t.string   "nickname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "marketingtypes", force: true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.integer  "filter"
    t.boolean  "global",           default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "index_number"
    t.boolean  "is_mobile",        default: false
    t.integer  "searchings_count", default: 0,     null: false
    t.integer  "products_count",   default: 0,     null: false
  end

  create_table "members", force: true do |t|
    t.integer  "company_id"
    t.integer  "user_id"
    t.boolean  "owner",      default: false
    t.boolean  "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", force: true do |t|
    t.integer  "level"
    t.text     "information"
    t.boolean  "is_important"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payables", force: true do |t|
    t.integer  "payment_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", force: true do |t|
    t.string   "name"
    t.text     "fee_detail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "procons", force: true do |t|
    t.integer  "country_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prodocuments", force: true do |t|
    t.integer  "prolang_id"
    t.string   "name"
    t.string   "saved_name"
    t.text     "original_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.integer  "marketingtype_id"
    t.integer  "company_id"
    t.boolean  "saved"
    t.integer  "minimum_budget"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "products", ["deleted_at"], name: "index_products_on_deleted_at"

  create_table "proimages", force: true do |t|
    t.integer  "detail_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "projects", force: true do |t|
    t.integer  "publisher_id"
    t.integer  "advertiser_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.integer  "money"
    t.datetime "payment_date"
    t.integer  "status"
    t.boolean  "refunded"
    t.integer  "result_rate"
    t.text     "result_comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prolangs", force: true do |t|
    t.integer  "product_id"
    t.integer  "language_id"
    t.text     "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "receipts", force: true do |t|
    t.integer  "project_id"
    t.integer  "receipt_number"
    t.datetime "date"
    t.float    "cost"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "searchings", force: true do |t|
    t.integer  "user_id"
    t.integer  "country_id"
    t.integer  "marketingtype_id"
    t.integer  "platform"
    t.float    "cost_from"
    t.float    "cost_to"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "translanguages", force: true do |t|
    t.string   "name"
    t.string   "nickname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "translations", force: true do |t|
    t.integer  "from_id"
    t.integer  "to_id"
    t.integer  "translanguage_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "usernotis", force: true do |t|
    t.integer  "user_id"
    t.integer  "notification_id"
    t.text     "content"
    t.boolean  "is_deleted",      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.integer  "company_id"
    t.integer  "credit",                 default: 0
    t.boolean  "is_admin",               default: false
    t.string   "email",                  default: "",    null: false
    t.boolean  "email_confirmed",        default: false
    t.boolean  "company_confirmed",      default: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "first_name",             default: "",    null: false
    t.string   "last_name",              default: "",    null: false
    t.boolean  "news_mailing"
    t.boolean  "bidding_mailing"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "deleted_at"
    t.integer  "searchings_count",       default: 0,     null: false
  end

  add_index "users", ["deleted_at"], name: "index_users_on_deleted_at"
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
