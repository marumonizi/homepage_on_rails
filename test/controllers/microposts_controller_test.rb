require "test_helper"

class MicropostsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @micropost = microposts(:most_recent)
  end

  test "get micropost show follow home" do
    get micropost_path(@micropost)
    assert_template 'microposts/show'
  end
  
  test "should get index" do
    get microposts_path
    assert_template 'microposts/index'
  end
end
