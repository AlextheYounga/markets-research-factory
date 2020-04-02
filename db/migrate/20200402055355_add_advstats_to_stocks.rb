class AddAdvstatsToStocks < ActiveRecord::Migration[5.2]
  def change
    add_column :stocks, :ev_to_sales, :decimal
    add_column :stocks, :profit_margin, :decimal
    add_column :stocks, :enterprise_value_to_revenue, :decimal
    add_column :stocks, :price_to_sales, :decimal
    add_column :stocks, :ebitda, :decimal
    add_column :stocks, :revenue, :decimal
  end
end
