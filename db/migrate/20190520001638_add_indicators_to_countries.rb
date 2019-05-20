class AddIndicatorsToCountries < ActiveRecord::Migration[5.2]
  def change
    add_column :countries, :inflation, :string
    add_column :countries, :corporate_tax, :string
    add_column :countries, :interest_rate, :string
    add_column :countries, :unemployment, :string
    add_column :countries, :income_tax, :string
    add_column :countries, :gdp, :string
    add_column :countries, :gov_debt_to_gdp, :string
    add_column :countries, :bank_balance_sheet, :string
    add_column :countries, :central_bank, :string
    add_column :countries, :budget, :string
  end
end
