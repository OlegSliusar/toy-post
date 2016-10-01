require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:oleh)
  end

  test "layout links" do
    get root_path
    assert_template 'microposts/index'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", edit_user_path(@user), count: 0
    log_in_as(@user)
    follow_redirect!
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", edit_user_path(@user)
  end
end