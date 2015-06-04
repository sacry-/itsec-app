class PasswordResetsController < ApplicationController

  def new
  end

  def show
  end
  
  def create
    @user = User.find_by_email(params[:password_reset][:email].downcase)
    if not @user.nil?
      @user.create_reset_digest
      redirect_to password_reset_url(
        @user.reset_token,
        email: @user.email,
        user_id: @user.id
      )
    else
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end

  def edit
    before_action
  end

  def update
    before_action
    if params[:user][:password].empty?
      flash.now[:danger] = "Password can't be empty"
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:success] = "Password has been reset."
      redirect_to @user
    else
      render 'edit'
    end
  end

private
  def before_action
    get_user
    valid_user
    check_expiration
  end

  def get_user
    @user = User.find_by_email(params[:email])
  end

  def valid_user
    unless (@user && @user.activated? &&
            @user.authenticated?(:reset, params[:id]))
      redirect_to root_url
    end
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = "Password reset has expired."
      redirect_to new_password_reset_url
    end
  end

  def user_params
    return {} if (params[:user].nil? || params[:user][:password].nil? || params[:user][:password_confirmation].nil?)
    new_params = {}
    new_params[:password] = params[:user][:password]
    new_params[:password_confirmation] = params[:user][:password_confirmation]
    new_params
  end
end
