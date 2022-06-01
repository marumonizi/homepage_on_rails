require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_path
    assert_template  'static_pages/home'
  end

  test "should get about" do
    get about_path
    assert_template  'static_pages/about'
  end

  test "should get contact" do
    get contact_path
    assert_template  'static_pages/contact'
  end

  test "should get accsess" do
    get access_path
    assert_template  'static_pages/access'
  end
end
