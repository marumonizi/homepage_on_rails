require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @product = products(:nizimasu_sioyaki)
    @user = users(:admin_user)
  end

  test "should get show" do
    assert @product.valid?
    log_in_as(@user)
    get product_path(@product)
    assert_template 'products/show'
  end

  test "should get index" do
    get products_path
    assert_template 'products/index'
  end
end
