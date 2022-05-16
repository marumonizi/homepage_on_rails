require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:admin_user)
    @other_user =users(:no_admin_user)
    @michael = users(:michael)
  end

  test "should get new" do
    get new_user_path
    assert_response :success
  end

  test "should get show when logged in" do
    log_in_as(@user)
    get user_path(@user)
    assert_template 'users/show'
  end

  
  test "should redirect show when not logged in" do
    get user_path(@user)
    assert_redirected_to login_path
    follow_redirect!
    assert_not flash.empty?
    assert_template 'sessions/new'
  end

  test "should redirect show when logged in wrong user" do
    log_in_as(@other_user)
    get user_path(@user)
    assert_redirected_to root_path
    follow_redirect!
    assert_not flash.empty?
    assert_template 'static_pages/home'
  end

  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_path
  end
  
  test "should get index when not logged in admin user" do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
  end

  test "should redirect index when logged in no admin user" do
    log_in_as(@other_user)
    get users_path
    assert_redirected_to login_path
  end
end