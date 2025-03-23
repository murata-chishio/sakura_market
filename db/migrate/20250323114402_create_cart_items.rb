class CreateCartItems < ActiveRecord::Migration[8.0]
  def change
    create_table :cart_items do |t|
      t.integer :quantity, default: 0
      t.references :cart, null: false, foreign_key: true, index: false
      t.references :product, null: false, foreign_key: true

      t.timestamps
      t.index %i[cart_id product_id], unique: true
    end
  end
end
