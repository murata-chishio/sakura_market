class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_cart

  # 未ログインユーザーのカートは後から実装する
  def current_cart
    current_user.cart || current_user.create_cart
  end

  protected

  def configure_permitted_parameters
    added_attrs = %i[name postcode prefecture address_city address_street address_building]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
    devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
  end
end
