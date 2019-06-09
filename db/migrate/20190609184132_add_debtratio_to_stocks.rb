class AddDebtratioToStocks < ActiveRecord::Migration[5.2]
  def change
    add_column :stocks, :debt_to_assets, :decimal
  end
end
