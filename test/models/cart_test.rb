require "test_helper"

class CartTest < ActiveSupport::TestCase
  def setup
    @user = users(:admin_user)
    
  end

  test "should cart have presence valid user id" do
    cart = Cart.new(user_id: 99)
    assert_not cart.valid?
    cart = Cart.new(user_id: nil)
    assert_not cart.valid?
  end

  test "valid cart have user" do
    cart = @user.build_cart
    assert cart.valid?
  end
end
