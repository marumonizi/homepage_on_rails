require "test_helper"

class UserLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:admin_user)
  end
  
  # 名前もパスワードも空
  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { name: '',
                                          password: '' } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  # 名前とパスワードが不一致
  test "login with invalid name" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { name: 'sample',
                                          password: '1234567' } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  # 名前とパスワードが不一致
  test "login with invalid password" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { name: @user.name,
                                          password: '1234567' } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  # 正しいログインとログアウト
  test "login with valid information " do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { name: @user.name,
                                          password: 'password' } }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select 'h1.user', @user.name
    delete logout_path
    assert_redirected_to root_path
    follow_redirect!
    assert_select 'a[href=?]', login_path, count: 1
  end

  
  # 自動ログイン0FF
  test "login without remembering" do
    log_in_as(@user, remember_me: '1')
    delete logout_path
    log_in_as(@user, remember_me: '0')
    assert_empty cookies[:remember_token]
  end

  # 自動ログイン0N
  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_not_empty cookies[:remember_token]
  end
end
