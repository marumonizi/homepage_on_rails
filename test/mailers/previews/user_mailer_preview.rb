# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/acount_activation
  def acount_activation
    user = User.second
    user.activation_token = User.new_token
    UserMailer.acount_activation(user)
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/password_reset
  def password_reset
    user = User.second
    user.reset_token = User.new_token
    UserMailer.password_reset(user)
  end

end
