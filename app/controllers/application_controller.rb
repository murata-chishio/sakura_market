class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :current_cart

  # 未ログインユーザーのカートは後から実装する
  def current_cart
    current_user.cart || current_user.create_cart
  end
end
