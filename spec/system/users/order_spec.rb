RSpec.describe '購入履歴', type: :system do
  let!(:user) do
    create(:user,
           name: '佐藤 太郎',
           postcode: '1008111',
           prefecture: '東京都',
           address_city: '千代田区',
           address_street: '千代田１−１')
  end

  before do
    sign_in(user, scope: :user)
  end

  describe '履歴の一覧' do

    before do
      product = create(:product, name: 'キャベツ', price: 2000)
      order = create(:order,
                    user:,
                    created_at: '2025-03-25 12:00',
                    delivery_date: Order.calculate_business_days(5),
                    delivery_time: '8-12')
    end

    it '一覧に情報が表示されている' do
      visit users_orders_path
      expect(page).to have_content '佐藤 太郎'
      expect(page).to have_content 'user@example.com'
      expect(page).to have_content Order.calculate_business_days(5).strftime("%Y年%m月%d日")
      expect(page).to have_content '8-12'
    end
  end

  describe '履歴の詳細' do
    before do
      product = create(:product, name: 'キャベツ', price: 2000)
      order = create(:order, user:, delivery_date: Order.calculate_business_days(5), delivery_time: '8-12')
      create(:order_item, order:, product:, quantity: 15)
    end

    it '詳細に情報が表示されている' do
      visit users_orders_path
      click_link '佐藤 太郎'
      expect(page).to have_content '1008111 東京都 千代田区 千代田１−１'
      expect(page).to have_content 'キャベツ'
      expect(page).to have_content '15'
    end
  end
end
