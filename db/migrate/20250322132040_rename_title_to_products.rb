class RenameTitleToProducts < ActiveRecord::Migration[8.0]
  def change
    rename_column :products, :name, :name
  end
end
