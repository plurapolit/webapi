# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.with_attached_avatar.all
  end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def update
    remove_empty_password_on_update

    if @user.update(user_params)
      redirect_to users_path, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: 'User was successfully destroyed.'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:organisation_id, :email,
                                 :role, :password,
                                 :first_name, :last_name,
                                 :biography,
                                 :twitter_handle, :facebook_handle,
                                 :linkedin_handle, :website_link,
                                 :avatar)
  end

  def remove_empty_password_on_update
    return unless params[:user][:password].blank? && params[:user][:password_confirmation].blank?

    params[:user].delete(:password)
    params[:user].delete(:password_confirmation)
  end
end
