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

  test "should get inquiry" do
    get inquiry_path
    assert_template  'static_pages/inquiry'
  end

  test "should get accsess" do
    get access_path
    assert_template  'static_pages/access'
  end
end
