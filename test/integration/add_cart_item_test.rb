require "test_helper"

class AddCartItemTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:admin_user)
    @product = products(:sinsyusalmon_osasimi)
  end
  
  test "should be cart item quantity" do
    log_in_as(@user)
    get product_path(@product)
    assert_template 'products/show'
    assert_no_difference "CartItem.count" do
      post add_item_path, params: { quantity: nil,
                                    product_id: @product.id }
    assert_redirected_to products_url
    follow_redirect!
    assert_template 'products/index'
    assert_select 'div.notice', text: "カートへの追加に失敗しました"
    end
  end

  test "should be cart item product id" do
    log_in_as(@user)
    get product_path(@product)
    assert_template 'products/show'
    assert_no_difference "CartItem.count" do
      post add_item_path, params: { quantity: "1",
                                    product_id: nil }
    assert_redirected_to products_url
    follow_redirect!
    assert_template 'products/index'
    assert_select 'div.notice', text: "カートへの追加に失敗しました"
    end
  end

  test "valid add cart item infomation" do
    log_in_as(@user)
    get product_path(@product)
    assert_template 'products/show'
    assert_difference "CartItem.count", 1 do
      post add_item_path, params: { quantity: 1,
                                    product_id: @product.id}
    end
    assert_redirected_to my_cart_path
    follow_redirect!
    assert_template 'carts/index'
    assert_select 'div.notice', text: "カートへ追加しました"
  end
end
