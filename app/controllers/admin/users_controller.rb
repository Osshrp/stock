class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  authorize_resource

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    set_role
    respond_with(:admin, @user)
  end

  def edit
  end

  def update
    @user.update(user_params)
    set_role
    respond_with(:admin, @user)
  end

  def destroy
    respond_with(:admin, @user.destroy)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation,
                                 :current_password)
  end

  def set_role
    @user.roles.destroy_all
    @user.add_role(Role.find(params[:role]).name)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
