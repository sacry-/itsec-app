class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to current_user
    end
  end

  def create
    user = User.find_by_name(session_params[:name])
    if user && user.authenticate(session_params[:password])
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid name/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

private
  def session_params
    params[:session]
  end
end
