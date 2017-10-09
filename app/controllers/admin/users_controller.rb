class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
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
    respond_with(:admin, @user)
  end

  def edit
  end

  def update
    params[:user].delete(:password) if params[:user][:password].blank?
    if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
      params[:user].delete(:password_confirmation)
    end
    @user.update(user_params)
    respond_with(:admin, @user)
  end

  def destroy
    respond_with(:admin, @user.destroy)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
