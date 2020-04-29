class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.string :ticker
      t.string :company_name
      t.decimal :latest_price
      t.decimal :gross_profit
      t.decimal :marketcap
      t.decimal :net_income
      t.decimal :net_worth
      t.decimal :total_assets
      t.decimal :total_liabilities
      t.decimal :total_debt
      t.decimal :debt_to_equity
      t.decimal :day50_moving_avg
      t.decimal :day200_moving_avg
      t.decimal :day5_change_percent
      t.decimal :day30_change_percent
      t.decimal :month1_change_percent
      t.decimal :month3_change_percent
      t.decimal :month6_change_percent
      t.decimal :ytd_change_percent
      t.decimal :year1_change_percent
      t.decimal :year2_change_percent
      t.decimal :year5_change_percent
      t.decimal :max_changepercent
      t.decimal :week52high
      t.decimal :dividend_yield
      t.decimal :pe_ratio
      t.decimal :revenue
      t.decimal :profit_margin
      t.decimal :enterprise_value
      t.decimal :ev_to_sales
      t.decimal :ev_to_revenue
      t.decimal :price_to_sales
      t.decimal :price_to_book
      t.decimal :ebitda
      t.decimal :put_call_ratio
      t.string :period
      t.string :report_date
      t.string :industry
      t.string :description
      t.string :primary_exchange
      t.datetime :latest_time
      t.datetime :latest_update
    end
  end
end
