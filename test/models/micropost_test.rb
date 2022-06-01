require "test_helper"

class MicropostTest < ActiveSupport::TestCase

  def setup
    @user = users(:admin_user)
    @micropost = @user.microposts.build( title:   "test_title",
                                         content: "test_content",
                                         image: "test_jpeg")
  end
  
  # user_idが含まれていること
  test "user id should be present" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end
  
  # title存在すること
  test "title id should be present" do
    @micropost.title = nil
    assert_not @micropost.valid?
  end
  
  # contentが存在すること
  test "content id should be present" do
    @micropost.content = nil
    assert_not @micropost.valid?
  end
  
  # 正しい投稿内容
  test "shold be valid" do
    assert @micropost.valid?
  end
  
  # 作成日の降順
  test "order should be most recent first" do
    assert_equal microposts(:most_recent), Micropost.first
  end
end
