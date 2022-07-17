class UserMailer < ApplicationMailer
  def acount_activation(user)
    @user = user
    mail to: user.email, subject: "【穂高共同食品】仮会員登録のお知らせ"
  end

  def password_reset

  end
end
