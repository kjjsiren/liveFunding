require 'test_helper'

class NewsfeedTest < ActiveSupport::TestCase

  test "invalid with empty attributes" do
    comment = Comment.new
    assert !comment.valid?
    assert comment.errors.invalid?(:content)
    assert comment.errors.invalid?(:commenter)

  end
end
