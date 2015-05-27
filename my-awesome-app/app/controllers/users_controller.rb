class UsersController < ApplicationController

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    @user = User.find_by_id(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Successfully updated attributes!"
      redirect_to @user
    else
      render 'edit'
    end
  end

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
    h = {}
    h[:name] = user_hash[:name] unless user_hash[:name].nil?
    h[:email] = user_hash[:email] unless user_hash[:email].nil?
    h[:password] = user_hash[:password] unless user_hash[:password].nil?
    h[:admin] = user_hash[:admin] unless user_hash[:admin].nil?
    h
  end
end
