require "test_helper"

class UserCreateTest < ActionDispatch::IntegrationTest
  
  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "should be presence user name " do
    get new_user_path
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: " ",
                                         email: "admin@user.com",
                                         password: "123456",
                                         password_confirmation: "123456" } }
    end
    assert_template 'users/new'
  end

  test "should be presence password " do
    get new_user_path
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: "test",
                                         email: "admin@user.com",
                                         password: "",
                                         password_confirmation: "123456" } }
    end
    assert_template 'users/new'
  end

  test "should be presence password confirmation " do
    get new_user_path
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: "test",
                                         email: "admin@user.com",
                                         password: "123456",
                                         password_confirmation: "" } }
    end
    assert_template 'users/new'
  end

  test "shoud match password combination" do
    get new_user_path
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: "test",
                                         email: "admin@user.com",
                                         password: "123456",
                                         password_confirmation: "password" } }
    end
    assert_template 'users/new'
  end

  test "should be unique email" do
    get new_user_path
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: "admin",
                                         email: "admin@user.com",
                                         password: "password",
                                         password_confirmation: "password" } }
    end
    assert_template 'users/new'
  end

  test "should be presense email" do
    get new_user_path
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: "admin",
                                         email: "",
                                         password: "password",
                                         password_confirmation: "password" } }
    end
    assert_template 'users/new'
  end

  test "should not assignment admin" do
    get new_user_path
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: "test",
                                         email: "test@email.com",
                                         password: "12356",
                                         password_confirmation: "123456",
                                         admin: true } }
    end
    assert_template 'users/new'
  end

  test "valid new user" do
    get new_user_path
    assert_response :success
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: "test",
                                         email: "test@email.com",
                                         password: "123456",
                                         password_confirmation: "123456" } }
    end
    assert_redirected_to users_done_url
    assert_not is_logged_in?
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?
    log_in_as(user)
    assert_not is_logged_in?
    get edit_acount_activation_path("invalid_token", email: user.email)
    assert_not is_logged_in?
    get edit_acount_activation_path(user.activation_token, email: "invalid@email.com")
    assert_not is_logged_in?
    get edit_acount_activation_path(user.activation_token, email: user.email)
    follow_redirect!
    assert_template 'users/done'
    assert is_logged_in?
  end
end
