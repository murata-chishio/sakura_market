module ImageHelper
  def product_image(product, image_size = :preview, class_options: '')
    settings = Product::IMAGE_SETTINGS
    width = settings[:"#{image_size}_width"]
    height = settings[:"#{image_size}_height"]
    if product.image.attached?
      image_tag product.image.variant(image_size), class: class_options
    else
      image_tag 'default_image.png', width: width, height: height, class: class_options
    end
  end
end
