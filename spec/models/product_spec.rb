RSpec.describe Product, type: :model do
  describe '#price_with_tax' do
    it '消費税を加えた値が表示されること' do
      product = Product.new(price: 2000)
      expect(product.price_with_tax).to eq(2200)
    end
  end

  describe 'price' do
    it '0以上の値ではない場合、登録できないこと' do
      product = build(:product, price: -1)
      expect(product).not_to be_valid
      expect(product.errors).to be_of_kind(:price, :greater_than_or_equal_to)
    end
  end
end
