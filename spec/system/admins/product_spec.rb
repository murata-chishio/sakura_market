RSpec.describe '商品の機能', type: :system do
  let!(:admin) { create(:admin) }

  before do
    sign_in(admin, scope: :admin)
  end

  describe '商品の登録' do
    it '商品の登録ができること' do
      visit admins_products_path
      click_link '新規登録'
      click_button '登録する'
      expect(page).to have_content('タイトルを入力してください')
      fill_in 'タイトル', with: 'キャベツ'
      fill_in '金額(税抜)', with: '2000'
      click_button '登録する'
      expect(page).to have_content 'キャベツ'
      expect(page).to have_content '2,000'
    end
  end

  describe '商品の一覧' do
    before do
      create(:product, title: 'キャベツ', price: '2000')
    end

    it '一覧画面に商品が表示されていること' do
      visit admins_products_path
      expect(page).to have_content 'キャベツ'
      expect(page).to have_content '2,000'
      # 税込の金額
      expect(page).to have_content '2,200'
    end
  end

  describe '商品の詳細' do
    before do
      create(:product, title: 'キャベツ', price: '2000', image: file_fixture('tomato.png'))
    end

    it '詳細画面に必要な情報が表示されていること' do
      visit admins_products_path
      click_link 'キャベツ'
      expect(page).to have_content 'キャベツ'
      expect(page).to have_content '金額(税抜) : 2,000'
      expect(page).to have_content '金額(税込) : 2,200'
      expect(page).to have_selector("img[src$='tomato.png']")
    end
  end

  describe '商品の編集' do
    let(:product) { create(:product, title: 'キャベツ') }

    it '編集できること' do
      visit admins_product_path(product)
      expect(page).to have_content 'キャベツ'
      click_on '編集'

      fill_in 'タイトル',	with: 'トマト'
      click_on '更新する'

      expect(page).to have_content 'トマト'
    end
  end

  describe '商品の削除' do
    let(:product) { create(:product, title: 'キャベツ') }

    it '商品を削除できること' do
      visit admins_product_path(product)
      expect(page).to have_content 'キャベツ'
      accept_confirm('本当に削除しますか？') do
        click_on '削除'
      end
      expect(page).to have_current_path admins_products_path
      expect(page).not_to have_content 'キャベツ'
    end
  end
end
