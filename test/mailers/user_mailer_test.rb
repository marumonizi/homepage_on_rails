require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "acount_activation" do
    user = users(:no_admin_user)
    user.activation_token = User.new_token
    mail = UserMailer.acount_activation(user)
    assert_equal "【穂高共同食品】仮会員登録のお知らせ", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["#{ Rails.application.credentials[:google][:user_name] }"], mail.from
    assert_match user.name, mail.text_part.body.encoded
    assert_match user.name, mail.html_part.body.encoded
    assert_match CGI.escape(user.email), mail.text_part.body.encoded
    assert_match CGI.escape(user.email), mail.html_part.body.encoded
  end

  # test "password_reset" do
  #   mail = UserMailer.password_reset
  #   assert_equal "Password reset", mail.subject
  #   assert_equal ["to@example.org"], mail.to
  #   assert_equal ["from@example.com"], mail.from
  #   assert_match "Hi", mail.body.encoded
  # end

end
