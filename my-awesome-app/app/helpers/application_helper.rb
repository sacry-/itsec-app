module ApplicationHelper

  def user_activation_expired?(user)
    user.activation_started < (Time.now - 30.minutes)
  end

end