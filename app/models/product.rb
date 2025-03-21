class Product < ApplicationRecord
  IMAGE_SETTINGS = {
    content_types: ['image/png', 'image/jpeg'],
    preview_width: 500,
    preview_height: 500,
  }.freeze

  has_one_attached :image do |attachable|
    preview_width = IMAGE_SETTINGS[:preview_width]
    preview_height = IMAGE_SETTINGS[:previes_height]
    attachable.variant :preview, resize_to_limit: [preview_width, preview_height]
  end

  validates :image, content_type: IMAGE_SETTINGS[:content_types]

  scope :default_order, -> { order(updated_at: :desc, id: :desc) }
end
