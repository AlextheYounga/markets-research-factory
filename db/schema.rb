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

ActiveRecord::Schema.define(version: 2019_10_26_211316) do

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.string "print_name"
    t.string "inflation"
    t.string "corporate_tax"
    t.string "interest_rate"
    t.string "unemployment"
    t.string "income_tax"
    t.string "gdp"
    t.string "gov_debt_to_gdp"
    t.string "bank_balance_sheet"
    t.string "central_bank"
    t.string "budget"
  end

  create_table "dailyquotes", force: :cascade do |t|
    t.string "symbol"
    t.string "company_name"
    t.datetime "date"
    t.json "data"
  end

  create_table "stocks", force: :cascade do |t|
    t.string "symbol"
    t.string "company_name"
    t.decimal "latest_price"
    t.decimal "gross_profit"
    t.decimal "net_income"
    t.decimal "total_assets"
    t.decimal "total_liabilities"
    t.decimal "total_debt"
    t.decimal "pe_ratio"
    t.datetime "latest_time"
    t.datetime "latest_update"
    t.string "period"
    t.string "report_date"
    t.string "industry"
    t.string "description"
    t.string "primary_exchange"
    t.decimal "moving_average"
    t.decimal "debt_to_assets"
    t.decimal "net_worth"
  end

end
