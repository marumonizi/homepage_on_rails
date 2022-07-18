require "test_helper"

class UserLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:admin_user)
  end
  
  test "should be presence email" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "",
                                          password: "password" } }
    assert_template 'sessions/new'
    assert_select 'div.flash-notifications', text: "メールアドレス又はパスワードが間違っています。"
    get root_path
    assert flash.empty?
  end

  test "login with invalid email" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "tstt@mail.com",
                                          password: 'password' } }
    assert_template 'sessions/new'
    assert_select 'div.flash-notifications', text: "メールアドレス又はパスワードが間違っています。"
    get root_path
    assert flash.empty?
  end
    
  test "should be presence password" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: @user.email,
                                          password: '' } }
    assert_template 'sessions/new'
    assert_select 'div.flash-notifications', text: "メールアドレス又はパスワードが間違っています。"
    get root_path
    assert flash.empty?
  end

  test "should be presence name and password" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: @user.email,
                                          password: '' } }
    assert_template 'sessions/new'
    assert_select 'div.flash-notifications', text: "メールアドレス又はパスワードが間違っています。"
    get root_path
    assert flash.empty?
  end
  
  test "login with invalid password" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: @user.email,
                                          password: '1234567' } }
    assert_template 'sessions/new'
    assert_select 'div.flash-notifications', text: "メールアドレス又はパスワードが間違っています。"
    get root_path
    assert flash.empty?
  end

  test "login with valid information " do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: @user.email,
                                          password: 'password' } }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    delete logout_path
    assert_redirected_to root_path
    follow_redirect!
    assert_template 'static_pages/home'
  end

  test "login without remembering" do
    log_in_as(@user, remember_me: '1')
    delete logout_path
    log_in_as(@user, remember_me: '0')
    assert_empty cookies[:remember_token]
  end

  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_not_empty cookies[:remember_token]
  end
end
