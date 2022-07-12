require "test_helper"

class CartItemTest < ActiveSupport::TestCase
  def setup
    @cart = carts(:cart1)
    @product = products(:nizimasu_sioyaki)
    @cart_item = @cart.cart_items.new(product_id: @product.id, quantity: 1)
  end

  test "should presence cart item quantity" do
    @cart_item.quantity = nil
    assert_not @cart_item.valid?
  end

  test "should be number cart item quantity" do
    @cart_item.quantity = "abc"
    assert_not @cart_item.valid?
  end

  test "should presence cart item product id" do
    @cart_item.product_id = nil
    assert_not @cart_item.valid?
  end

  test "should presence cart item cart id" do
    @cart_item.cart_id = nil
    assert_not @cart_item.valid?
  end

  test "valid cart item" do
    assert @cart.valid?
    assert @cart_item.valid?
  end

  test "order should be first resent item" do
    assert_equal cart_items(:cart_item1), CartItem.first
  end
end
