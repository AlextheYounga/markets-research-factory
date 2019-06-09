class AddMovingaverageToStocks < ActiveRecord::Migration[5.2]
  def change
    add_column :stocks, :moving_average, :decimal
  end
end
