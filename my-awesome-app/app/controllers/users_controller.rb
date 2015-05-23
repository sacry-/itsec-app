class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Successfully signed up!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find_by_id(params[:id])
  end

  def destroy
    user = User.find_by_id(params[:id])
    unless user.nil?
      user.destroy
    end
    redirect_to :root
  end

private
  def user_params
    user_hash = params[:user]
    { 
      name: user_hash[:name],
      email: user_hash[:email],
      password: user_hash[:password],
      admin: user_hash[:admin]
    }
  end
end
