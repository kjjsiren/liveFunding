require 'test_helper'

class EntityTest < ActiveSupport::TestCase
  test "invalid with empty attributes" do
    entity = Comment.new
    assert !entity.valid?
    assert entity.errors.invalid?(:content)
    assert entity.errors.invalid?(:commenter)
  end
end
