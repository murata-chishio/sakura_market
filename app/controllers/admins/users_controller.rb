class Admins::UsersController < Admins::ApplicationController
  before_action :set_user, only: %i[edit update destroy]
  def index
    @users = User.all
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admins_users_path, notice: t('controller.created')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy!
    redirect_to admins_users_path, status: :see_other, notice: t('controller.deleted')
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.expect(user: %i[email password password_confirmation])
  end
end
