RSpec.describe '商品の閲覧', type: :system do
  describe '商品の一覧' do
    before do
      create(:product, name: 'キャベツ', price: '2000')
      create(:product, name: 'トマト', price: '4000')
    end

    it '一覧画面に商品が表示されていること' do
      visit products_path
      expect(page).to have_content 'キャベツ'
      expect(page).to have_content '2,200'
      expect(page).to have_content 'トマト'
      expect(page).to have_content '4,400'
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
      visit products_path
      click_on 'キャベツ'
      expect(page).to have_content 'キャベツ'
      expect(page).to have_content '金額(税込) : 2,200'
      expect(page).to have_selector("img[src$='tomato.png']")
      expect(page).to have_selector 'h3', text: '定番！万能なキャベツ♪'
      expect(page).to have_selector 'strong', text: '春に出回るものは「春キャベツ」と呼ばれる'
    end
  end
end
