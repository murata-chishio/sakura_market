class UpdateQuantityDefaultInCartItems < ActiveRecord::Migration[8.0]
  def up
    change_column_default :cart_items, :quantity, from: 1, to: 0
  end

  def down
    change_column_default :cart_items, :quantity, from: 0, to: 1
  end
end
