class AddPrintToCountries < ActiveRecord::Migration[5.2]
  def change
    add_column :countries, :print_name, :string
  end
end
