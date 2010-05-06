require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "invalid with empty attributes" do
    user = User.new
    assert !user.valid?
    assert user.errors.invalid?(:user_username)
  end
end
