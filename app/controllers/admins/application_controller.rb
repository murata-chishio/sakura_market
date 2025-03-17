class Admins::ApplicationController < ApplicationController
  before_action :authenticate_admin!
  allow_browser versions: :modern
  layout 'admin/application'
end
