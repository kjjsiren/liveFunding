require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  
  test "invalid with empty attributes" do
    comment = Comment.new
    assert !comment.valid?
    assert comment.errors.invalid?(:content)
    assert comment.errors.invalid?(:commenter)
  end
  
  test "commenter name length test" do
    comment = Comment.new(:content => "Plaaplaa",
                          :commenter => "John")
                          
    comment.commenter = "Q"
    assert !comment.errors.invalid?(:commenter)
    
    comment.commenter = "JohnMattiKeijoJyrkiMaija"
    assert !comment.errors.invalid?(:commenter)
    
    comment.commenter = "Perry"
    assert comment.valid?
    
  end  
    
  test "comment content length test" do
    comment = Comment.new(:content => "Plaaplaa",
                          :commenter => "John")
                          
    comment.content = "Q"
    assert !comment.errors.invalid?(:content)
    
    comment.content = "JohnMattiKeijoJyrkiMaija"
    assert !comment.errors.invalid?(:content)
    
    comment.content = "Perry"
    assert comment.valid?
    
  end
    
end
