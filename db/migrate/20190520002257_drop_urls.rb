class DropUrls < ActiveRecord::Migration[5.2]
  def change
    drop_table :urls
  end
end
