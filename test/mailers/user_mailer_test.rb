require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  def setup
    @user = users(:oleh)
  end

  test "password_reset" do
    mail = UserMailer.password_reset(@user)
    assert_equal "Password reset", mail.subject
    assert_equal [@user.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end
end
