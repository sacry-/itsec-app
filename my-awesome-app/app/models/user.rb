class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :admin, :name, :email, :password, :password_digest

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true
  validates :password, presence: true, length: { minimum: 3, maximum: 6 }, allow_nil: true

  def admin?
    self.admin == 1
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end