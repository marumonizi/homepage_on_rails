require "test_helper"

class UserCreateTest < ActionDispatch::IntegrationTest
  test "invalid user " do
    get new_user_path
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: " ",
                                         password: "123456",
                                         password_confirmation: "123456" } }
    end
    assert_template 'users/new'
  end
  
  test "invalid password user " do
    get new_user_path
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: "test",
                                         password: "123",
                                         password_confirmation: "123" } }
    end
    assert_template 'users/new'
  end

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
