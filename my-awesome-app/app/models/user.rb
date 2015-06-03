class User < ActiveRecord::Base
  attr_accessor :remember_token, :activation_token
  before_save   :downcase_email
  before_create :create_activation_digest

  has_secure_password

  attr_accessor :remember_token

  attr_accessible :admin, 
                  :name,
                  :email, 
                  :password, 
                  :password_confirmation, 
                  :password_digest,
                  :activated,
                  :activated_at,
                  :activation_started

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true
  validates :password, allow_nil: true, length: { minimum: 3, maximum: 6 }

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def User.per_page
    30
  end

  def User.new_remember_token
    User.new_token
  end

  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  def admin?
    self.admin == 1
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def downcase_email
    self.email = email.downcase
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    cost = BCrypt::Engine::MIN_COST
    BCrypt::Password.create(token, cost: cost)
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end