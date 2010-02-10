require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  
  test "invalid with empty attributes" do
    comment = Comment.new
    assert !comment.valid?
    assert comment.errors.invalid?(:content)
  end
end
