require 'test_helper'

class MicropostsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @micropost = microposts(:one)
    @user = users(:oleh)
  end
  
  test "should redirect create when not logged in" do
    assert_no_difference 'Micropost.count' do
      post microposts_path, params: { micropost: { content: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Micropost.count' do
      delete micropost_path(@micropost)
    end
    assert_redirected_to login_url
  end

  test "should get index" do
    get microposts_url
    assert_response :success
  end

#   test "should create micropost" do
#     assert_difference('Micropost.count') do
#       post microposts_url, params: { micropost: { content: @micropost.content,
#         user_id: @micropost.user_id } }
#     end
#
#     assert_redirected_to new_micropost_url
#   end
#
  test "should show micropost" do
    get micropost_url(@micropost)
    assert_response :success
  end

  test "should get edit when logged in" do
    log_in_as(@user)
    get edit_micropost_url(@micropost)
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get edit_micropost_url(@micropost)
    assert_redirected_to login_path
  end

#   test "should update micropost" do
#     patch micropost_url(@micropost), params: { micropost: { content: @micropost.content, user_id: @micropost.user_id } }
#     assert_redirected_to micropost_url(@micropost)
#   end

  test "should destroy micropost" do
    log_in_as(@user)
    assert_difference('Micropost.count', -1) do
      delete micropost_url(@micropost)
    end

    assert_redirected_to root_url
  end

  test "should redirect destroy for wrong micropost" do
    log_in_as(users(:archer))
    assert_no_difference 'Micropost.count' do
      delete micropost_path(@micropost)
    end
    assert_redirected_to root_url
  end
end
