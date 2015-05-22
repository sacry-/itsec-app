class UsersController < ApplicationController
  def new
  end

  def index
    User.all
  end
end
