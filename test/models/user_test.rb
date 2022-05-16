require "test_helper"

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "test", password:"123456", password_confirmation: "123456")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be presence" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "name should not too long" do
    @user.name = "a" * 30
    assert_not @user.valid?
  end

  test "should presence password not be valid" do
    @user.password = "no"
    assert_not @user.valid?
  end
  
  test "password should not too long" do
    @user.password = "a" * 30
    assert_not @user.valid?
  end

end
