require "test_helper"

class MicropostCreateTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:admin_user)
  end

  test "should be presence micopost title" do
    log_in_as(@user)
    get new_micropost_path
    assert_no_difference "Micropost.count" do
      post microposts_path, params: { micropost: { title: "",
                                                   content: "test_content_news"} }
    end
    assert_template 'microposts/new'
  end

  test "should be presence micopost content" do
    log_in_as(@user)
    get new_micropost_path
    assert_no_difference "Micropost.count" do
      post microposts_path, params: { micropost: { title: "test_news_title",
                                                   content: "" } }
    end
    assert_template 'microposts/new'
  end

  test "valid microposts information" do
    log_in_as(@user)
    get new_micropost_path
    assert_template 'microposts/new'
    assert_difference "Micropost.count" do
      post microposts_path, params: { micropost: { title: "news",
                                                   content: "news content",
                                                   image: "test.png" } }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', microposts_path(@micropost)
  end
end
