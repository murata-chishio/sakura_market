class Product < ApplicationRecord
  has_one_attached :image
  scope :default_order, -> { order(updated_at: :desc, id: :desc) }
end
