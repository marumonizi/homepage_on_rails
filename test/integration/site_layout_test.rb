require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:admin_user)
    @micropost = microposts(:most_recent)
    @contact = contacts(:first_contact)
  end

  # ホーム
  test "home layout links follow session link" do
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
    delete logout_path
    follow_redirect!
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', new_micropost_path, count:0
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

  # お問い合わせ詳細
  test "contact show link" do
    log_in_as(@user)
    get contact_path(@contact)
    assert_template 'contacts/show'
    assert 'div.contact-name', @contact.name
    assert 'div.message', @contact.message
    assert_select 'a[href=?]', root_path, count: 4
    assert_select 'a[href=?]', contacts_path
  end

  # お問い合わせ一覧
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


end
