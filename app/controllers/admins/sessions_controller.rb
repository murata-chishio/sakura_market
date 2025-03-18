class Admins::SessionsController < Devise::SessionsController
  def after_sign_in_path_for(resource)
    admins_root_path
  end
end
