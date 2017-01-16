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

ActiveRecord::Schema.define(version: 20170116044637) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "budgets", force: :cascade do |t|
    t.integer  "amount"
    t.integer  "expense_category_id"
    t.integer  "user_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "expense_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_expense_categories_on_user_id", using: :btree
  end

  create_table "expenses", force: :cascade do |t|
    t.integer  "user_id"
    t.float    "amount"
    t.integer  "vendor_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "expense_category_id"
    t.text     "note"
    t.integer  "recurring_expense_id"
    t.index ["expense_category_id"], name: "index_expenses_on_expense_category_id", using: :btree
    t.index ["recurring_expense_id"], name: "index_expenses_on_recurring_expense_id", using: :btree
    t.index ["user_id"], name: "index_expenses_on_user_id", using: :btree
    t.index ["vendor_id"], name: "index_expenses_on_vendor_id", using: :btree
  end

  create_table "income_categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_income_categories_on_user_id", using: :btree
  end

  create_table "incomes", force: :cascade do |t|
    t.float    "amount"
    t.integer  "user_id"
    t.integer  "vendor_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "income_category_id"
    t.text     "note"
    t.integer  "recurring_income_id"
    t.index ["income_category_id"], name: "index_incomes_on_income_category_id", using: :btree
    t.index ["recurring_income_id"], name: "index_incomes_on_recurring_income_id", using: :btree
    t.index ["user_id"], name: "index_incomes_on_user_id", using: :btree
    t.index ["vendor_id"], name: "index_incomes_on_vendor_id", using: :btree
  end

  create_table "pending_expenses", force: :cascade do |t|
    t.float    "amount"
    t.integer  "user_id"
    t.integer  "vendor_id"
    t.integer  "expense_category_id"
    t.text     "note"
    t.integer  "recurring_expense_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.boolean  "cleared",              default: false
    t.index ["expense_category_id"], name: "index_pending_expenses_on_expense_category_id", using: :btree
    t.index ["recurring_expense_id"], name: "index_pending_expenses_on_recurring_expense_id", using: :btree
    t.index ["user_id"], name: "index_pending_expenses_on_user_id", using: :btree
    t.index ["vendor_id"], name: "index_pending_expenses_on_vendor_id", using: :btree
  end

  create_table "recurring_expenses", force: :cascade do |t|
    t.float    "amount"
    t.integer  "user_id"
    t.integer  "vendor_id"
    t.integer  "expense_category_id"
    t.text     "note"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "frequency"
    t.integer  "due_day"
    t.boolean  "archived",            default: false
    t.index ["archived"], name: "index_recurring_expenses_on_archived", using: :btree
    t.index ["due_day"], name: "index_recurring_expenses_on_due_day", using: :btree
    t.index ["expense_category_id"], name: "index_recurring_expenses_on_expense_category_id", using: :btree
    t.index ["frequency"], name: "index_recurring_expenses_on_frequency", using: :btree
    t.index ["user_id"], name: "index_recurring_expenses_on_user_id", using: :btree
    t.index ["vendor_id"], name: "index_recurring_expenses_on_vendor_id", using: :btree
  end

  create_table "recurring_incomes", force: :cascade do |t|
    t.float    "amount"
    t.integer  "user_id"
    t.integer  "vendor_id"
    t.integer  "income_category_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.text     "note"
    t.integer  "frequency"
    t.integer  "due_day"
    t.boolean  "archived",           default: false
    t.index ["archived"], name: "index_recurring_incomes_on_archived", using: :btree
    t.index ["due_day"], name: "index_recurring_incomes_on_due_day", using: :btree
    t.index ["frequency"], name: "index_recurring_incomes_on_frequency", using: :btree
    t.index ["income_category_id"], name: "index_recurring_incomes_on_income_category_id", using: :btree
    t.index ["user_id"], name: "index_recurring_incomes_on_user_id", using: :btree
    t.index ["vendor_id"], name: "index_recurring_incomes_on_vendor_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",  null: false
    t.string   "encrypted_password",     default: "",  null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,   null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.float    "beginning_cash_on_hand", default: 0.0
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "vendors", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.text     "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_vendors_on_user_id", using: :btree
  end

end
