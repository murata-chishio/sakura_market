class AddDeliveryDateAndTimeToOrders < ActiveRecord::Migration[8.0]
  def change
    change_table :orders, bulk: true do |t|
      t.date :delivery_date
      t.string :delivery_time
    end
  end
end
