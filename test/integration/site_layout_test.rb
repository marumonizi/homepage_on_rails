require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:admin_user)
    @micropost = microposts(:most_recent)
  end

  # ホーム
  test "home layout links follow session link" do
    log_in_as(@user)
    get root_path
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', root_path,  count: 3
    assert_select 'a[href=?]', about_path, count: 2
    assert_select 'a[href=?]', contact_path, count: 2
    assert_select 'a[href=?]', access_path, count: 2
    assert_select 'a[href=?]', microposts_path, count: 2
    assert_select 'a.news-content', count:5
    assert_select 'a[href=?]', logout_path
    delete logout_path
    follow_redirect!
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', login_path
  end

  # マイクロポスト詳細
  test "micropost show link" do
    get micropost_path(@micropost)
    assert_template 'microposts/show'
    assert 'div.news-detail', @micropost.title
    assert 'div.news-detail', @micropost.content
    assert 'div.news-detail', @micropost.image
    assert_select 'a[href=?]', root_path, count: 4
    assert_select 'a[href=?]', microposts_path
  end

  # マイクロポスト一覧
  test "micropost index link" do
    get microposts_path
    assert_template 'microposts/index'
    assert 'nav.pagination'
    Micropost.page(1).each do |micropost|
      assert_select 'a[href=?]', micropost_path(micropost)
    end
    assert_select 'a[href=?]', root_path, count: 4
  end
end
