RSpec.describe 'カートの機能', type: :system do
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

  describe 'カートへの本の追加' do
    let(:product) { create(:product, name: 'キャベツ', price: 2000) }

    before do
      create(:cart, user: user)
    end

    it '商品をカートに入れることができる' do
      visit product_path(product)
      fill_in '個数', with: '3'
      click_button 'カートに追加'
      expect(page).to have_content 'カートに追加しました。'
      visit cart_path
      expect(page).to have_content 'キャベツ'
      expect(page).to have_content '金額(税込) : 6,600円'
    end
  end

  describe 'カートの詳細画面' do
    before do
      product = create(:product,
                       name: 'キャベツ',
                       price: 2000)
      cart = create(:cart, user: user)
      create(:cart_item, cart: cart, product: product, quantity: 2)
    end

    it '住所が表示されている' do
      visit cart_path
      expect(page).to have_content '佐藤 太郎'
      expect(page).to have_content '1008111 東京都 千代田区 千代田１−１'
    end

    it '商品を削除できる' do
      visit root_path
      click_link 'カート'

      expect(page).to have_content 'キャベツ'
      expect(page).to have_content '4,400'
      accept_alert('カートから削除しますか？') do
        click_button '削除'
      end
      expect(page).to have_content 'カートに商品が入っていません'
    end

    it '本を購入できる' do
      visit cart_path
      expect(page).to have_content 'キャベツ'
      expect(page).to have_content '4,400'
      fill_in '配送日', with: Order.calculate_business_days(3)
      select '8-12', from: '配送時間'
      click_button '購入'
      expect(page).to have_content '購入しました。'
    end
  end
end
