RSpec.describe 'カートの機能', type: :system do
  let!(:user) { create(:user) }

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
      create(:cart_item, cart: cart, product: product)
    end

    it '本を削除できる' do
      visit root_path
      click_link 'カート'

      expect(page).to have_content 'キャベツ'
      expect(page).to have_content '2,200'
      accept_alert('カートから削除しますか？') do
        click_button '削除'
      end
      expect(page).to have_content 'カートに商品が入っていません'
    end
  end
end
