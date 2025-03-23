RSpec.describe Cart, type: :model do
  let!(:user) { create(:user) }

  describe '#subtotal_price' do
    let(:cart) { create(:cart, user:) }

    before do
      product1 = create(:product, price: 1000)
      product2 = create(:product, price: 2000)
      create(:cart_item, cart:, product: product1)
      create(:cart_item, cart:, product: product2)
    end

    it '商品の合計金額(税抜)が表示されること' do
      expect(cart.subtotal_price).to eq 3000
    end
  end

  describe '#delivery_fee' do
    let(:cart) { create(:cart, user:) }

    before do
      product1 = create(:product)
      product2 = create(:product)
      create(:cart_item, cart:, product: product1)
      create(:cart_item, cart:, product: product2)
    end

    it '代引き手数料が表示されていること' do
      expect(cart.delivery_fee).to eq 300
    end
  end

  describe '#shipping_fee' do
    let(:cart) { create(:cart, user:) }

    before do
      product1 = create(:product)
      product2 = create(:product)
      create(:cart_item, cart:, product: product1)
      create(:cart_item, cart:, product: product2)
    end

    it '送料が表示されていること' do
      expect(cart.shipping_fee).to eq 600
    end
  end

  describe '#tax_amount' do
    let(:cart) { create(:cart, user:) }

    before do
      product1 = create(:product, price: 1000)
      product2 = create(:product, price: 2000)
      create(:cart_item, cart:, product: product1)
      create(:cart_item, cart:, product: product2)
    end

    it '商品と代引き手数料と送料の税が表示されていること' do
      expect(cart.tax_amount).to eq 390
    end
  end

  describe '#payment_total' do
    let(:cart) { create(:cart, user:) }

    before do
      product1 = create(:product, price: 1000)
      product2 = create(:product, price: 2000)
      create(:cart_item, cart:, product: product1)
      create(:cart_item, cart:, product: product2)
    end

    it '支払いの合計が表示されていること' do
      expect(cart.payment_total).to eq 4290
    end
  end
end
