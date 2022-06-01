require "test_helper"

class UserCreateTest < ActionDispatch::IntegrationTest

  # 名前が空
  test "should be presence user name " do
    get new_user_path
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: " ",
                                         password: "123456",
                                         password_confirmation: "123456" } }
    end
    assert_template 'users/new'
  end

  # パスワードが空
  test "should be presence password " do
    get new_user_path
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: "test",
                                         password: "",
                                         password_confirmation: "123456" } }
    end
    assert_template 'users/new'
  end

  # 確認用パスワードが空
  test "should be presence password confirmation " do
    get new_user_path
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: "test",
                                         password: "123456",
                                         password_confirmation: "" } }
    end
    assert_template 'users/new'
  end

  # パスワードが不一致
  test "shoud match password combination" do
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
  test "should be unique name" do
    get new_user_path
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: "admin",
                                         password: "password",
                                         password_confirmation: "password" } }
    end
    assert_template 'users/new'
  end

  # 管理者権限を付与
  test "should not assignment admin" do
    get new_user_path
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: "test",
                                         password: "12356",
                                         password_confirmation: "123456",
                                         admin: true } }
    end
    assert_template 'users/new'
  end

  # アカウント作成成功
  test "valid new user" do
    get new_user_path
    assert_response :success
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: "test",
                                         password: "123456",
                                         password_confirmation: "123456" } }
    end
    follow_redirect!
    assert_select 'div.flash-notifications', text:"アカウントが作成されました"
    assert_template 'users/show'
    assert is_logged_in?
  end
end
