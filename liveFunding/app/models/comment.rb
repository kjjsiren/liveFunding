#Comments belong to transactions. Each comment belongs to a transaction and to a user.
class Comment < ActiveRecord::Base
  validates_presence_of :content, :commenter	# Content and commenter can't be empty
  validates_length_of :commenter, :in => 2..15	# Minimum content is 2 characters,and max is 15
  validates_length_of :content, :in => 2..2000
  belongs_to :transaction						# One transaction has many comments			
  belongs_to :user								
 end
