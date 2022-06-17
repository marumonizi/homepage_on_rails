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
    assert_select 'div.danger', text:"ログインしてください"
    assert_template 'sessions/new'
  end
  
  # 他のユーザー
  test "should redirect show when logged in wrong user" do
    log_in_as(@other_user)
    get user_path(@user)
    assert_redirected_to root_path
    follow_redirect!
    assert_template 'static_pages/home'
  end
  
  # ログイン時
  test "should get show when logged in" do
    log_in_as(@user)
    get user_path(@user)
    assert_select 'div.page-title', text: @user.name
    assert_template 'users/show'
  end

  # ユーザー一覧へのアクセス
  # 未ログイン
  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_path
    follow_redirect!
    assert_select 'div.danger', text:"ログインしてください"
    assert_template 'sessions/new'
  end
  
  # 非管理者
  test "should redirect index when logged in no admin user" do
    log_in_as(@other_user)
    get users_path
    assert_redirected_to login_path
    follow_redirect!
    assert_select 'div.danger', text:"管理用アカウントでログインしてください"
    assert_template 'sessions/new'
  end

  # 管理者
  test "should get index when not logged in admin user" do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
    assert_select 'div.user-name', count: 3
  end

  #マイクロポスト

  # new
  test "should redirect get new when not logged in" do
    get new_micropost_path
    assert_redirected_to login_path
    follow_redirect!
    assert_select 'div.danger', text:"ログインしてください"
    assert_template 'sessions/new'
  end

  test "should redirect get new when logged in not admin user" do
    log_in_as @other_user
    get new_micropost_path
    assert_redirected_to login_path
    follow_redirect!
    assert_select 'div.danger', text:"管理用アカウントでログインしてください"
    assert_template 'sessions/new'
  end
  
  test "should get new when logged in admin user" do
    log_in_as @user
    get new_micropost_path
    assert_template 'microposts/new'
  end


  # お問い合わせ
  
  # 一覧

  test "should redirect index when not login" do
    get contacts_path
    assert_redirected_to login_url
    follow_redirect!
    assert_select 'div.danger', text:"管理用アカウントでログインしてください"
    assert_template 'sessions/new'
  end
  
  test "should redirect index when not admin user" do
    log_in_as(@other_user)
    get contacts_path
    assert_redirected_to login_url
    follow_redirect!
    assert_select 'div.danger', text:"管理用アカウントでログインしてください"
    assert_template 'sessions/new'
  end
  
  test "should get index when admin user" do
    log_in_as(@user)
    get contacts_path
    assert_template 'contacts/index'
    assert_select 'div.contacts-name', conunt:5
  end

  #詳細
  test "sshould redirect index when not login" do
    @contact = contacts(:first_contact)
    get contact_path(@contact)
    assert_redirected_to login_url
    follow_redirect!
    assert_select 'div.danger', text:"管理用アカウントでログインしてください"
    assert_template 'sessions/new'
  end

  test "sshould redirect index when not admin user" do
    log_in_as(@other_user)
    @contact = contacts(:first_contact)
    get contact_path(@contact)
    assert_redirected_to login_url
    follow_redirect!
    assert_select 'div.danger', text:"管理用アカウントでログインしてください"
    assert_template 'sessions/new'
  end

  test "sshould get index when admin user" do
    log_in_as(@user)
    @contact = contacts(:first_contact)
    get contact_path(@contact)
    assert_template 'contacts/show'

  end
end
