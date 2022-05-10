require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @base_title = "虹鱒の養殖・加工の穂高共同食品"
  end

  test "should get home" do
    get root_path
    assert_response :success
    assert_select 'title', "#{@base_title} | ホーム"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select 'title', "#{@base_title} | 会社概要"
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select 'title', "#{@base_title} | お問い合わせ"
  end

  test "should get access" do
    get access_path
    assert_response :success
    assert_select 'title', "#{@base_title} | アクセス"
  end

end
