require "test_helper"

class UserCreateTest < ActionDispatch::IntegrationTest

  # 名前が空
  test "invalid user name " do
    get new_user_path
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: " ",
                                         password: "123456",
                                         password_confirmation: "123456" } }
    end
    assert_template 'users/new'
  end
  
  # パスワードが不適切
  test "invalid password" do
    get new_user_path
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: "test",
                                         password: "123",
                                         password_confirmation: "123" } }
    end
    assert_template 'users/new'
  end

  # パスワードが不一致
  test "invalid password combination " do
    get new_user_path
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: "test",
                                         password: "123456",
                                         password_confirmation: "password" } }
    end
    assert_template 'users/new'
  end

  # すでに登録されている名前
  test "arlady name" do
    get new_user_path
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: "admin",
                                         password: "password",
                                         password_confirmation: "password" } }
    end
    assert_template 'users/new'
  end

  # アカウント作成成功
  test "valid new user " do
    get new_user_path
    assert_response :success
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: "test",
                                         password: "123456",
                                         password_confirmation: "123456" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end
end
