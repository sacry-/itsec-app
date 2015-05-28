class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :admin, :name, :email, 
                  :password, :password_confirmation, 
                  :password_digest

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true
  validates :password, allow_nil: true, length: { minimum: 3, maximum: 6 }

  def self.per_page
    30
  end

  def admin?
    self.admin == 1
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end