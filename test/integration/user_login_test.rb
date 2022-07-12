require "test_helper"

class UserLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:admin_user)
  end
  
  test "should be presence name" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { name: '',
                                          password: "password" } }
    assert_template 'sessions/new'
    assert_select 'div.flash-notifications', text: "アカウント名又はパスワードが間違っています。"
    get root_path
    assert flash.empty?
  end
    
  test "should be presence password" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { name: @user.name,
                                          password: '' } }
    assert_template 'sessions/new'
    assert_select 'div.flash-notifications', text: "アカウント名又はパスワードが間違っています。"
    get root_path
    assert flash.empty?
  end

  test "should be presence name and password" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { name: '',
                                          password: '' } }
    assert_template 'sessions/new'
    assert_select 'div.flash-notifications', text: "アカウント名又はパスワードが間違っています。"
    get root_path
    assert flash.empty?
  end
  
  test "login with invalid password" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { name: @user.name,
                                          password: '1234567' } }
    assert_template 'sessions/new'
    assert_select 'div.flash-notifications', text: "アカウント名又はパスワードが間違っています。"
    get root_path
    assert flash.empty?
  end
    
  test "login with invalid name" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { name: 'sample',
                                          password: 'password' } }
    assert_template 'sessions/new'
    assert_select 'div.flash-notifications', text: "アカウント名又はパスワードが間違っています。"
    get root_path
    assert flash.empty?
  end

  test "login with valid information " do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { name: @user.name,
                                          password: 'password' } }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select 'div.page-title', @user.name
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
