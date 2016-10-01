require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  test "users pagination" do
    get users_path
    assert_template 'users/index'
    assert_select "div.pagination", count: 2
    User.paginate(page: 1).each do |user|
      assert_select "a[href=?]", user_path(user), text: user.name
      assert_match user.email, response.body
    end
  end
end
