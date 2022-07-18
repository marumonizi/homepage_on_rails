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

  test "password_reset" do
    user = users(:no_admin_user)
    user.reset_token = User.new_token
    mail = UserMailer.password_reset(user)
    assert_equal "【穂高共同食品】パスワード再設定について", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["#{ Rails.application.credentials[:google][:user_name] }"], mail.from
    assert_match user.name, mail.text_part.body.encoded
    assert_match user.name, mail.html_part.body.encoded
    assert_match CGI.escape(user.email), mail.text_part.body.encoded
    assert_match CGI.escape(user.email), mail.html_part.body.encoded
    assert_match (user.reset_sent_at + 1.hours).to_s(:datetime_jp_time), mail.text_part.body.encoded
    assert_match (user.reset_sent_at + 1.hours).to_s(:datetime_jp_time), mail.html_part.body.encoded
  end
end
