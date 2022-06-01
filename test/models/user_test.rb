require "test_helper"

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "test", password:"123456", password_confirmation: "123456")
  end

  
  test "name should be presence" do
    @user.name = nil
    assert_not @user.valid?
  end
  
  test "name should not too long" do
    @user.name = "a" * 30
    assert_not @user.valid?
  end
  
  test "should presence password" do
    @user.password = nil
    assert_not @user.valid?
  end
  
  test "password should not too short" do
    @user.password = "a" * 5
    @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
  
  test "password should not too long" do
    @user.password = "a" * 51
    @user.password_confirmation = "a" * 51
    assert_not @user.valid?
  end

  test "should presence password comfirmation" do
    @user.password_confirmation = nil
    assert_not @user.valid?
  end
  
  test "should match password and password comfirmation" do
    @user.password_confirmation = "password"
    assert_not @user.valid?
  end

  test "should be valid" do
    assert @user.valid?
  end
end
