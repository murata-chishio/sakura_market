class ChangePrefectureCodeToPrefecture < ActiveRecord::Migration[8.0]
  def up
    change_table :users, bulk: true do |t|
      t.remove :prefecture_code
      t.string :prefecture
    end
  end

  def down
    change_table :users, bulk: true do |t|
      t.remove :prefecture
      t.integer :prefecture_code
    end
  end
end
