class CreateDailyquotes < ActiveRecord::Migration[5.2]
  def change
    create_table :dailyquotes do |t|
      t.string :symbol
      t.string :company_name
      t.datetime :date
      t.json :data
    end
  end
end
