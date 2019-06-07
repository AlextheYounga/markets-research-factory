class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.string "symbol"
      t.string "company_name"
      t.decimal "latest_price"
      t.number "net_income"
      t.datetime "latest_time"
      t.datetime "latest_update"
    end
  end
end
