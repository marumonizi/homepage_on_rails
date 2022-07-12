require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:admin_user)
    @micropost = microposts(:most_recent)
    @contact = contacts(:first_contact)
    @product = products(:nizimasu_sioyaki)
    
  end

  test "application layout links" do
    log_in_as(@user)
    get root_path
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', root_path,  count: 3
    assert_select 'a[href=?]', about_path, count: 2
    assert_select 'a[href=?]', new_contact_path, count: 2
    assert_select 'a[href=?]', access_path, count: 2
    assert_select 'a[href=?]', microposts_path, count: 2
    assert_select 'a.news-content', count:5
    assert_select 'a[href=?]', logout_path
    assert_select 'a[href=?]', new_micropost_path
    assert_select 'a[href=?]', products_path
    assert_select 'a[href=?]', new_product_path
    assert_select 'a[href=?]', my_cart_path
    delete logout_path
    follow_redirect!
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', new_micropost_path, count:0
  end

  test "micropost show link" do
    get micropost_path(@micropost)
    assert_template 'microposts/show'
    assert 'div.news-detail', @micropost.title
    assert 'div.news-detail', @micropost.content
    assert 'div.news-detail', @micropost.image
    assert_select 'a[href=?]', root_path, count: 4
    assert_select 'a[href=?]', microposts_path
  end

  test "micropost index link" do
    get microposts_path
    assert_template 'microposts/index'
    assert 'nav.pagination'
    Micropost.page(1).each do |micropost|
      assert_select 'a[href=?]', micropost_path(micropost)
    end
    assert_select 'a[href=?]', root_path, count: 4
  end

  test "contact show link" do
    log_in_as(@user)
    get contact_path(@contact)
    assert_template 'contacts/show'
    assert 'div.contact-name', @contact.name
    assert 'div.message', @contact.message
    assert_select 'a[href=?]', root_path, count: 4
    assert_select 'a[href=?]', contacts_path
  end

  test "contact index link" do
    log_in_as(@user)
    get contacts_path
    assert_template 'contacts/index'
    assert 'nav.pagination'
    Contact.page(1).each do |contact|
      assert_select 'a[href=?]', contact_path(contact)
    end
    assert_select 'a[href=?]', root_path, count: 4
  end

  test "product show link" do
    log_in_as(@user)
    get product_path(@product)
    assert_select 'div.product_show-name', "#{@product.name}"
    assert_select 'div.product_show-price', "#{@product.price}円/匹 (税込)"
    assert_select 'img[src=?]', @product.images[0].to_s
    assert_select 'img[src=?]', @product.images[1].to_s
    assert_select 'p', "#{@product.introduction}"
    assert_select 'div.product_cart-price', "#{@product.price}円/匹 (税込)"
    assert_select 'select#quantity'
    assert_select 'input.product_show-btn'
    
  end

  test "product index link" do
    get products_path
    Product.all.each do |product|
      assert_select 'a[href=?]', product_path(product)
      assert_select 'img[src=?]', product.images[0].to_s
      assert_select 'div.product_index-price', "#{product.price}円/匹 (税込)"
      assert_select 'p', "#{@product.introduction}"
    end
    assert_select 'a[href=?]', root_path, count:4
  end

  test "mycart link" do
    @cart = carts(:cart1)
    @cart_items = @cart.cart_items
    log_in_as(@user)
    get my_cart_path
    assert_template 'carts/index'
    @cart_items.each do |cart_item|
      assert_select 'img[src=?]', cart_item.product.images[0].to_s
      assert_select 'div.mycart_show-name', text: cart_item.product.name
      assert_select 'div.mycart_show-price', text: "価格#{cart_item.product.price}円/匹 (税込)"
      assert_select 'a[href=?]', delete_item_path(cart_item, product_id: cart_item.product.id)
      assert_select 'select#quantity'
      assert_select 'input[value=?]', "更新"
    end
    assert_select 'a[href=?]', root_path, count:4
  end
end
