class Product < ApplicationRecord
  TAX_RATE = 0.1
  IMAGE_SETTINGS = {
    content_types: ['image/png', 'image/jpeg'],
    max_size: 5.megabytes,
    preview_width: 500,
    preview_height: 500,
    thumbnail_width: 200,
    thumbnail_height: 300,
  }.freeze

  has_one_attached :image do |attachable|
    preview_width = IMAGE_SETTINGS[:preview_width]
    preview_height = IMAGE_SETTINGS[:preview_height]
    attachable.variant :preview, resize_to_limit: [preview_width, preview_height]

    thumbnail_width = IMAGE_SETTINGS[:thumbnail_width]
    thumbnail_height = IMAGE_SETTINGS[:thumbnail_height]
    attachable.variant :thumbnail, resize_to_limit: [thumbnail_width, thumbnail_height]
  end

  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :image, content_type: IMAGE_SETTINGS[:content_types], size: { less_than: IMAGE_SETTINGS[:max_size] }

  scope :default_order, -> { order(updated_at: :desc, id: :desc) }
  scope :default_order, -> { order(:position) }
  acts_as_list

  def price_with_tax
    (price * (1 + TAX_RATE)).floor
  end
end
