class CreateCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :countries do |t|
      t.string :name
      t.string :parameter
      t.string :code
      t.string :inflation
      t.string :corporate_tax
      t.string :interest_rate
      t.string :unemployment
      t.string :income_tax
      t.string :gdp
      t.string :gov_debt_to_gdp
      t.string :bank_balance_sheet
      t.string :central_bank
      t.string :budget
    end
  end
end
