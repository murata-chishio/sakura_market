class Product < ApplicationRecord
  TAX_RATE = 1.10
  IMAGE_SETTINGS = {
    content_types: ['image/png', 'image/jpeg'],
    preview_width: 500,
    preview_height: 500,
  }.freeze

  has_one_attached :image do |attachable|
    preview_width = IMAGE_SETTINGS[:preview_width]
    preview_height = IMAGE_SETTINGS[:preview_height]
    attachable.variant :preview, resize_to_limit: [preview_width, preview_height]
  end

  validates :title, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :image, content_type: IMAGE_SETTINGS[:content_types]

  scope :default_order, -> { order(updated_at: :desc, id: :desc) }

  def price_with_tax
    (price * TAX_RATE).floor
  end
end
