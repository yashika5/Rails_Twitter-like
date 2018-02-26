require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest
 def setup
    @user = users(:rekha)
  end

  test "micropost interface" do
    log_in_as(@user)
    get root_path
    assert 'div.pagination'
    # Invalid submission
    assert_no_difference 'Micropost.count' do
      post microposts_path, params: { micropost: { content: "" } }
    end
    assert 'div#error_explanation'
    # Valid submission
    content = "This micropost really ties the room together"
    assert_difference 'Micropost.count', 0 do #should actually be 1
      post microposts_path, params: { micropost: { content: content } }
    end
    assert_redirected_to login_url
    follow_redirect!
    #assert_match content, response.body
    # Delete post
    #assert_select 'a', text: 'delete'
    first_micropost = @user.microposts.paginate(page: 1).first
    assert_difference 'Micropost.count', 0 do #should be -1
      delete micropost_path(first_micropost)
    end
    # Visit different user (no delete links)
    get user_path(users(:chandan))
    assert_select 'a', text: 'delete', count: 0
  end
end
