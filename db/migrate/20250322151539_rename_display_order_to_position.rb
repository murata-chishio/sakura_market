class RenameDisplayOrderToPosition < ActiveRecord::Migration[8.0]
  def change
    rename_column :products, :display_order, :position
  end
end
