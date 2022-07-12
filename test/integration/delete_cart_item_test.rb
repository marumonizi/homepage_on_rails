require "test_helper"

class DeleteCartItemTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:admin_user)
    @cart_item = cart_items(:cart_item1)
  end

  test "delete cart item" do
    log_in_as(@user)
    assert_difference "CartItem.count", -1 do
      delete delete_item_path(@cart_item), params: {product_id: @cart_item.product_id}
    end
    assert_redirected_to my_cart_url
    follow_redirect!
    assert_template 'carts/index'
    assert_select 'div.notice', text: "商品を削除しました"
  end
end
