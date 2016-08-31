require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  def setup
    User.create(name: "Example User", email: "user@example.com",
                      password: "foobar", password_confirmation: "foobar")
    @micropost = Micropost.new(content: "This is example micropost for Toy Blogpost",
     user_id: 1)
  end

  # test "should be valid" do
  #   assert @micropost.valid?, "#{@micropost.errors.messages}"
  # end

  test "content should be present" do
    @micropost.content = "         "
    assert_not @micropost.valid?
  end

  test "user id should be present" do
    @micropost.user_id = "         "
    assert_not @micropost.valid?
  end

  test "content should not be too long" do
    @micropost.content = "a" * 141
    assert_not @micropost.valid?
  end
end
