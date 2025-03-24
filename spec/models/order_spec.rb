RSpec.describe Order, type: :model do
  describe '#validate_delivery_date_within_valid_range' do
    let(:user) { create(:user) }

    it '指定できない配送日時の商品は注文できない' do
      order = build(:order, user: user, delivery_date: Order.calculate_business_days(2), delivery_time: '8-12')
      order.valid?
      expect(order.errors.of_kind?(:delivery_date, :must_be_within_valid_range)).to eq(true)
    end
  end
end
