class User < ActiveRecord::Base
  attr_accessible :admin, :name, :email, :password
end
