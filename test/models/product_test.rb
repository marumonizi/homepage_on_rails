require "test_helper"

class ProductTest < ActiveSupport::TestCase
  def setup
    @product = Product.new(name: "虹鱒のフライ", price: "300", introduction: "美味しい魚",
                           images: [File.open("./app/assets/images/sioyaki.jpg"),
                                    File.open("./app/assets/images/mizu.png"),
                                    File.open("./app/assets/images/Iwana.jpg")])
  end

  test "should presence product name" do
    @product.name = " "
    assert_not @product.valid?
  end

  test "should be uniquness product name" do
    @product.name = "虹鱒の塩焼き"
    assert_not @product.valid?
  end

  test "should be not long product name" do
    @product.name = "a" * 101
    assert_not @product.valid?
  end
  
  test "should presence product price" do
    @product.price = ""
    assert_not @product.valid?
  end

  test "should be numericality product price" do
    @product.price = "a"
    assert_not @product.valid?
  end

  test "should fit range product price" do
    @product.price = "10001"
    assert_not @product.valid?
  end

  test "should be presence product introduction" do
    @product.introduction = ""
    assert_not @product.valid?
  end

  test "should be not too long product introduction" do
    @product.introduction = "a" * 501
    assert_not @product.valid?
  end

  test "should be presence product images" do
    @product.images = []
    assert_not @product.valid?
  end

  test "should valid product infomation" do
    assert @product.valid?
  end

  test "order should descend for created_at" do
    assert_equal Product.first, products(:nizimasu_sioyaki)
  end
end
