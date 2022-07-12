require "test_helper"

class UpdateCartItemTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:admin_user)
    @cart_item = cart_items(:cart_item1)
  end

  test "should be presence quantity update cart item" do
    log_in_as(@user)
    get my_cart_path
    assert_template 'carts/index'
    assert_no_difference "CartItem.count" do
      post update_item_path, params: { quantity: "",
                                       product_id: @cart_item.product_id } 
    end
    assert_redirected_to my_cart_path
    follow_redirect!
    assert_template 'carts/index'
    assert_select 'div.notice', text:"カートの更新に失敗しました"
    assert_equal @cart_item.reload.quantity, @cart_item.quantity
  end

  test "should be presence product id update cart item" do
    log_in_as(@user)
    get my_cart_path
    assert_template 'carts/index'
    assert_no_difference "CartItem.count" do
      post update_item_path, params: { quantity: "1",
                                       product_id: nil } 
    end
    assert_redirected_to my_cart_path
    follow_redirect!
    assert_template 'carts/index'
    assert_select 'div.notice', text:"カートの更新に失敗しました"
    assert_equal @cart_item.reload.quantity, @cart_item.quantity
  end

  test "valid update cart item infomation" do
    log_in_as(@user)
    get my_cart_path
    assert_template 'carts/index'
    post update_item_path, params: { quantity: "4",
                                     product_id: @cart_item.product_id } 
    assert_redirected_to my_cart_path
    follow_redirect!
    assert_template 'carts/index'
    assert_select 'div.notice', text:"カートを更新しました"
    assert_equal @cart_item.reload.quantity, 4
  end

  test "valid update cart item infomation and delete" do
    log_in_as(@user)
    get my_cart_path
    assert_template 'carts/index'
    assert_difference "CartItem.count", -1 do
      post update_item_path, params: { quantity: "0",
                                       product_id: @cart_item.product_id } 
    end
    assert_redirected_to my_cart_path
    follow_redirect!
    assert_template 'carts/index'
    assert_select 'div.notice', text:"商品を削除しました"
  end
end
