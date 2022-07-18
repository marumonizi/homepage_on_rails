require "test_helper"

class PasswordResetTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:no_admin_user)
  end

  test "password reset" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    #無効なメールアドレスを送信
    post password_resets_path, params: { password_reset: { email: "" } }
    assert_select 'div.danger', 'メールアドレスを確認してください'
    post password_resets_path, params: { password_reset: { email: "invalid@mail.com" } }
    assert_select 'div.danger', 'メールアドレスを確認してください'
    #有効なメールアドレスを送信
    post password_resets_path, params: { password_reset: { email: @user.email } }
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    #リンクのメールアドレスのみが間違っている
    user = assigns(:user)
    get edit_password_reset_path(user.reset_token, email: "")
    assert_redirected_to root_url
    #無効なユーザーが正しいリンクへのアクセス
    user.toggle!(:activated)
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_redirected_to root_url
    user.toggle!(:activated)
    #リンクのリセットトークンのみが間違っている
    get edit_password_reset_path('wrong_token', email: user.email)
    assert_redirected_to root_url
    # 正しいリンクへのアクセス
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_template 'password_resets/edit'
    assert_select "input[name=email][type=hidden][value=?]", user.email
    # パスワードが不一致
    patch password_reset_path(user.reset_token), params: { email: user.email,
                                                           user: { password: "password",
                                                           password_confirmation: "foobar" } }
    assert_template 'password_resets/edit'
    # パスワードが空
    patch password_reset_path(user.reset_token), params: { email: user.email,
                                                           user: { password: "",
                                                           password_confirmation: "" } }
    assert_template 'password_resets/edit'
    # 正しい送信
    patch password_reset_path(user.reset_token), params: { email: user.email,
                                                           user: { password: "password1234",
                                                           password_confirmation: "password1234" } }
    assert_redirected_to root_url
    assert is_logged_in?
  end
end
