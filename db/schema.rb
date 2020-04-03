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

ActiveRecord::Schema.define(version: 2019_06_07_055020) do

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.string "parameter"
    t.string "code"
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

  create_table "stocks", force: :cascade do |t|
    t.string "ticker"
    t.string "company_name"
    t.decimal "latest_price"
    t.decimal "gross_profit"
    t.decimal "marketcap"
    t.decimal "net_income"
    t.decimal "net_worth"
    t.decimal "total_assets"
    t.decimal "total_liabilities"
    t.decimal "total_debt"
    t.decimal "debt_to_equity"
    t.decimal "day50_moving_avg"
    t.decimal "day200_moving_avg"
    t.decimal "year5_changepercent"
    t.decimal "year2_changepercent"
    t.decimal "year1_changepercent"
    t.decimal "max_changepercent"
    t.decimal "week52high"
    t.decimal "dividend_yield"
    t.decimal "pe_ratio"
    t.decimal "revenue"
    t.decimal "profit_margin"
    t.decimal "enterprise_value"
    t.decimal "ev_to_sales"
    t.decimal "ev_to_revenue"
    t.decimal "price_to_sales"
    t.decimal "price_to_book"
    t.decimal "ebitda"
    t.decimal "put_call_ratio"
    t.string "period"
    t.string "report_date"
    t.string "industry"
    t.string "description"
    t.string "primary_exchange"
    t.datetime "latest_time"
    t.datetime "latest_update"
  end

end
