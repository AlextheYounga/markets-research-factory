class AddNetworthToStocks < ActiveRecord::Migration[5.2]
  def change
    add_column :stocks, :net_worth, :decimal
  end
end
