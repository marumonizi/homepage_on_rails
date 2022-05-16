require "test_helper"

class UserLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:admin_user)
  end
  
  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { name: "",
                                          password: '' } }
    assert_template 'sessions/new'
    assert_not flash.empty?
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
    assert_select 'h1.user'
  end

  test "should be logout" do
    delete logout_path
    assert_redirected_to root_path
    follow_redirect!
    assert_select 'a[href=?]', login_path, count: 1
  end
end
