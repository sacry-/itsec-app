class UsersController < ApplicationController

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    @user = User.find_by_id(params[:id])
    updated = @user.update_attributes(user_params)
    if updated
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
    create_params = user_params
    create_params["activation_started"] = Time.now
    @user = User.new(create_params)
    if @user.save
      redirect_to account_activation_url(
        @user.activation_token,
        email: @user.email,
        user_id: @user.id
      )
    else
      render 'new'
    end
  end

  def index
    @users = paginated_users
  end

  def show
    if params[:id].nil? and logged_in?
      @user = current_user
    else
      @user = User.find_by_id(params[:id])
    end
  end

  def destroy
    user = User.find_by_id(params[:id])
    is_accessible = accessible?(user)
    unless user.nil?
      user.destroy
    end
    if is_accessible
      redirect_to :root
    else
      @users = paginated_users
      render 'index'
    end
  end

  def me
    @user = current_user
  end

private
  def paginated_users
    User.paginate(page: params[:page])
  end

  def user_params
    if params[:user].blank?
      {}
    else
      filtered = params[:user].select{|_, v| not v.blank? }
      filtered["password"] = nil if filtered["password"].nil?
      filtered
    end
  end
end
