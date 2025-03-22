RSpec.describe '商品の機能', type: :system do
  let!(:admin) { create(:admin) }

  before do
    sign_in(admin, scope: :admin)
  end

  describe '商品の登録' do
    it '商品の登録ができること' do
      visit admins_products_path
      click_link '新規登録'
      attach_file '画像', Rails.root.join('spec/fixtures/files/radish.pdf')
      click_button '登録する'
      expect(page).to have_content('商品名を入力してください')
      expect(page).to have_content '金額(税抜)は数値で入力してください'
      expect(page).to have_content '画像は許可されていないファイル形式です'
      fill_in '商品名', with: 'キャベツ'
      fill_in '金額(税抜)', with: '2000'
      attach_file '画像', Rails.root.join('spec/fixtures/files/tomato.png')
      click_button '登録する'
      expect(page).to have_content 'キャベツ'
      expect(page).to have_content '2,000'
      expect(page).to have_selector("img[src$='tomato.png']")
    end
  end

  describe '商品の一覧' do
    before do
      create(:product, name: 'キャベツ', price: '2000')
      create(:product, name: 'トマト', price: '4000')
    end

    it '一覧画面に商品が表示されていること' do
      visit admins_products_path
      expect(page).to have_content 'キャベツ'
      expect(page).to have_content '2,000'
      # 税込の金額
      expect(page).to have_content '2,200'
      expect(page).to have_content 'トマト'
    end

    it '表示順を変更できること' do
      visit admins_products_path
      expect(page.text).to match(/キャベツ[\s\S]*トマト/)
      all('tr')[1].first('td').drag_to all('tr')[2].first('td')
      expect(page.text).to match(/トマト[\s\S]*キャベツ/)
      click on '表示順を更新'
      expect(page.text).to match(/トマト[\s\S]*キャベツ/)
    end
  end

  describe '商品の詳細' do
    before do
      create(:product, name: 'キャベツ', price: '2000', image: file_fixture('tomato.png'), description: <<~MARKDOWN)
        ### '定番！万能なキャベツ♪'

        **春に出回るものは「春キャベツ」と呼ばれる**
      MARKDOWN
    end

    it '詳細画面に必要な情報が表示されていること' do
      visit admins_products_path
      click_link 'キャベツ'
      expect(page).to have_content 'キャベツ'
      expect(page).to have_content '金額(税抜) : 2,000'
      expect(page).to have_content '金額(税込) : 2,200'
      expect(page).to have_selector("img[src$='tomato.png']")
      expect(page).to have_selector 'h3', text: '定番！万能なキャベツ♪'
      expect(page).to have_selector 'strong', text: '春に出回るものは「春キャベツ」と呼ばれる'
    end
  end

  describe '商品の編集' do
    let(:product) { create(:product, name: 'キャベツ') }

    it '編集できること' do
      visit admins_product_path(product)
      expect(page).to have_content 'キャベツ'
      click_on '編集'

      fill_in '商品名',	with: 'トマト'
      click_on '更新する'

      expect(page).to have_content 'トマト'
    end
  end

  describe '商品の削除' do
    let(:product) { create(:product, name: 'キャベツ') }

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
