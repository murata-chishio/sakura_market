class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :title, null: false
      t.integer :price
      t.text :description

      t.timestamps
    end
  end
end
