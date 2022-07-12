require "test_helper"

class MicropostTest < ActiveSupport::TestCase

  def setup
    @user = users(:admin_user)
    @micropost = @user.microposts.new( title:   "test_title",
                                         content: "test_content",
                                         image: "test_jpeg")
  end
  
  test "user id should be present" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end
  
  test "title id should be present" do
    @micropost.title = nil
    assert_not @micropost.valid?
  end
  
  test "content id should be present" do
    @micropost.content = nil
    assert_not @micropost.valid?
  end
  
  test "shold be valid" do
    assert @micropost.valid?
  end
  
  test "order should be first most recent " do
    assert_equal microposts(:most_recent), Micropost.first
  end
end
