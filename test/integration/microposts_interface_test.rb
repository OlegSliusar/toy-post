require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:malory)
  end

  test "micropost interface" do
    log_in_as(@user)
    get root_path
    # Invalid submission
    assert_no_difference 'Micropost.count' do
      post microposts_path, params: { micropost: { content: "" } }
    end
    assert_not flash.empty?
    # assert_select 'div#error_explanation' # implement error explanation later
    # Valid submission
    content = "This micropost really ties the room together"
    assert_difference 'Micropost.count', 1 do
      post microposts_path, params: { micropost: { content: content } }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
    # Delete post
    assert_select 'a', text: '| Delete'
    first_micropost = @user.microposts.first
    assert_difference 'Micropost.count', -1 do
      delete micropost_path(first_micropost)
    end
    # Visit different user (no delete links)
    get user_path(users(:archer))
    assert_select 'a', text: '| Delete', count: 0
  end

  test "micropost sidebar count" do
    @user = users(:oleh)
    log_in_as(@user)
    get user_path(@user)
    assert_match "#{@user.microposts.count} microposts", response.body
    # User with zero microposts
    other_user = users(:malory)
    log_in_as(other_user)
    get user_path(other_user)
    assert_match "0 microposts", response.body
    other_user.microposts.create!(content: "A micropost")
    get user_path(other_user)
    assert_match "1 microposts", response.body
  end
end
