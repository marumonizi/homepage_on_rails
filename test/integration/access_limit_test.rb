require "test_helper"

class AccessLimitTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:admin_user)
    @other_user =users(:no_admin_user)
    @michael = users(:michael)
  end
  
  test "should redirect session show when not logged in" do
    get user_path(@user)
    assert_redirected_to login_path
    follow_redirect!
    assert_select 'div.danger', text:"ログインしてください"
    assert_template 'sessions/new'
  end
  
  test "should redirect session show when logged in wrong user" do
    log_in_as(@other_user)
    get user_path(@user)
    assert_redirected_to root_path
    follow_redirect!
    assert_template 'static_pages/home'
  end
  
  test "should get session show when logged in" do
    log_in_as(@user)
    get user_path(@user)
    assert_select 'div.page-title', text: @user.name
    assert_template 'users/show'
  end

  test "should redirect user index when not logged in" do
    get users_path
    assert_redirected_to login_path
    follow_redirect!
    assert_select 'div.danger', text:"ログインしてください"
    assert_template 'sessions/new'
  end
  
  test "should redirect user index when logged in no admin user" do
    log_in_as(@other_user)
    get users_path
    assert_redirected_to login_path
    follow_redirect!
    assert_select 'div.danger', text:"管理用アカウントでログインしてください"
    assert_template 'sessions/new'
  end

  test "should get user index when not logged in admin user" do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
    assert_select 'div.user-name', count: 3
  end


  test "should redirect get  new when not logged in" do
    get new_micropost_path
    assert_redirected_to login_path
    follow_redirect!
    assert_select 'div.danger', text:"ログインしてください"
    assert_template 'sessions/new'
  end

  test "should redirect get micropost new when logged in not admin user" do
    log_in_as @other_user
    get new_micropost_path
    assert_redirected_to login_path
    follow_redirect!
    assert_select 'div.danger', text:"管理用アカウントでログインしてください"
    assert_template 'sessions/new'
  end
  
  test "should get micropost new when logged in admin user" do
    log_in_as @user
    get new_micropost_path
    assert_template 'microposts/new'
  end

  test "should redirect contact index when not login" do
    get contacts_path
    assert_redirected_to login_url
    follow_redirect!
    assert_select 'div.danger', text:"管理用アカウントでログインしてください"
    assert_template 'sessions/new'
  end
  
  test "should redirect contact index when not admin user" do
    log_in_as(@other_user)
    get contacts_path
    assert_redirected_to login_url
    follow_redirect!
    assert_select 'div.danger', text:"管理用アカウントでログインしてください"
    assert_template 'sessions/new'
  end
  
  test "should get contact index when admin user" do
    log_in_as(@user)
    get contacts_path
    assert_template 'contacts/index'
    assert_select 'div.contacts-name', conunt:5
  end

  test "should redirect contact show when not login" do
    @contact = contacts(:first_contact)
    get contact_path(@contact)
    assert_redirected_to login_url
    follow_redirect!
    assert_select 'div.danger', text:"管理用アカウントでログインしてください"
    assert_template 'sessions/new'
  end

  test "should redirect contact show when not admin user" do
    log_in_as(@other_user)
    @contact = contacts(:first_contact)
    get contact_path(@contact)
    assert_redirected_to login_url
    follow_redirect!
    assert_select 'div.danger', text:"管理用アカウントでログインしてください"
    assert_template 'sessions/new'
  end

  test "should get contact show when admin user" do
    log_in_as(@user)
    @contact = contacts(:first_contact)
    get contact_path(@contact)
    assert_template 'contacts/show'
  end

  test "should redirect product new when not login" do
    get new_product_path
    assert_redirected_to login_url
    follow_redirect!
    assert_select 'div.danger', text:"管理用アカウントでログインしてください"
    assert_template 'sessions/new'
  end

  test "should redirect product new when other user" do
    log_in_as(@other_user)
    get new_product_path
    assert_redirected_to login_url
    follow_redirect!
    assert_select 'div.danger', text:"管理用アカウントでログインしてください"
    assert_template 'sessions/new'
  end

  test "should get product new when login as admin user" do
    log_in_as(@user)
    get new_product_path
    assert_template 'products/new'
  end
  
  test "should redirect mycart when not login" do
    get my_cart_path
    assert_redirected_to login_url
    follow_redirect!
    assert_select 'div.danger', text:"ログインしてください"
    assert_template 'sessions/new'
  end

  test "should get mycart when login as admin user" do
    log_in_as(@user)
    get my_cart_path
    assert_template 'carts/index'
  end
end
