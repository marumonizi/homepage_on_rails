require "test_helper"

class ProductCreateTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:admin_user)
  end

  test "should be presence product name" do
    log_in_as(@user)
    get new_product_path
    assert_template 'products/new'
    assert_no_difference "Product.count" do
      post products_path, params: { product: { name:"",
                                               price: "300",
                                               introduction: "美味しい塩焼き",
                                               images: [Rack::Test::UploadedFile.new(Rails.root.join('test', 'fixtures', 'files', 'test.jpg')),
                                                        Rack::Test::UploadedFile.new(Rails.root.join('test', 'fixtures', 'files', 'test.jpg')) ] } }
    assert_template 'products/new'
    assert_select 'div.alert', "入力に誤りがあります"
    end
  end

  test "should be presence product price" do
    log_in_as(@user)
    get new_product_path
    assert_template 'products/new'
    assert_no_difference "Product.count" do
      post products_path, params: { product: { name:"塩焼き",
                                               price: "",
                                               introduction: "美味しい塩焼き",
                                               images: [Rack::Test::UploadedFile.new(Rails.root.join('test', 'fixtures', 'files', 'test.jpg')),
                                                        Rack::Test::UploadedFile.new(Rails.root.join('test', 'fixtures', 'files', 'test.jpg')) ] } }
    assert_template 'products/new'
    assert_select 'div.alert', "入力に誤りがあります"
    end
  end

  test "should be namber product price" do
    log_in_as(@user)
    get new_product_path
    assert_template 'products/new'
    assert_no_difference "Product.count" do
      post products_path, params: { product: { name:"塩焼き",
                                               price: "abcd",
                                               introduction: "美味しい塩焼き",
                                               images: [Rack::Test::UploadedFile.new(Rails.root.join('test', 'fixtures', 'files', 'test.jpg')),
                                                        Rack::Test::UploadedFile.new(Rails.root.join('test', 'fixtures', 'files', 'test.jpg')) ] } }
    assert_template 'products/new'
    assert_select 'div.alert', "入力に誤りがあります"
    end
  end

  test "should be namber product introduction" do
    log_in_as(@user)
    get new_product_path
    assert_template 'products/new'
    assert_no_difference "Product.count" do
      post products_path, params: { product: { name:"塩焼き",
                                               price: "300",
                                               introduction: "",
                                               images: [Rack::Test::UploadedFile.new(Rails.root.join('test', 'fixtures', 'files', 'test.jpg')),
                                                        Rack::Test::UploadedFile.new(Rails.root.join('test', 'fixtures', 'files', 'test.jpg')) ] } }
    assert_template 'products/new'
    assert_select 'div.alert', "入力に誤りがあります"
    end
  end

  test "should be namber product images" do
    log_in_as(@user)
    get new_product_path
    assert_template 'products/new'
    assert_no_difference "Product.count" do
      post products_path, params: { product: { name:"塩焼き",
                                               price: "300",
                                               introduction: "",
                                               images: [] } }
    assert_template 'products/new'
    assert_select 'div.alert', "入力に誤りがあります"
    end
  end

  test "valid product infomation" do
    log_in_as(@user)
    get new_product_path
    assert_template 'products/new'
    assert_difference "Product.count" do
      post products_path, params: { product: { name: "塩焼き",
                                               price: "300",
                                               introduction: "美味しい",
                                               images: [Rack::Test::UploadedFile.new(Rails.root.join('test', 'fixtures', 'files', 'test.jpg')),Rack::Test::UploadedFile.new(Rails.root.join('test', 'fixtures', 'files', 'test.jpg'))] } }
    end
    assert_redirected_to products_path
    follow_redirect!
    assert_template 'products/index'
    assert_select 'div.notice', "商品を登録しました"
  end

end
