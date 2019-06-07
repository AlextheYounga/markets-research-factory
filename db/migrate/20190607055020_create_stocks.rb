class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.string :company_name
      t.decimal :latest_price
      t.decimal :gross_profit
      t.decimal :net_income
      t.decimal :net_income
      t.decimal :total_assets
      t.decimal :total_liabilities
      t.decimal :total_debt
      t.decimal :pe_ratio
      t.datetime :latest_time
      t.datetime :latest_update
      t.string :period
      t.string :report_date
      t.string :industry
      t.string :description
      t.string :primary_exchange
    end
  end
end
