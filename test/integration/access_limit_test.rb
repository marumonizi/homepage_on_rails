require "test_helper"

class AccessLimitTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:admin_user)
    @other_user =users(:no_admin_user)
    @michael = users(:michael)
  end

  # ユーザー画面へのアクセス
  
  # 未ログイン
  test "should redirect show when not logged in" do
    get user_path(@user)
    assert_redirected_to login_path
    follow_redirect!
    assert_not flash.empty?
    assert_template 'sessions/new'
  end
  
  # 他のユーザー
  test "should redirect show when logged in wrong user" do
    log_in_as(@other_user)
    get user_path(@user)
    assert_redirected_to root_path
    follow_redirect!
    assert_not flash.empty?
    assert_template 'static_pages/home'
  end
  
  # ログイン時
  test "should get show when logged in" do
    log_in_as(@user)
    get user_path(@user)
    assert_template 'users/show'
  end

  # ユーザー一覧へのアクセス
  # 未ログイン
  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_path
  end
  
  # 非管理者
  test "should redirect index when logged in no admin user" do
    log_in_as(@other_user)
    get users_path
    assert_redirected_to login_path
  end

  # 管理者
  test "should get index when not logged in admin user" do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
  end
end
