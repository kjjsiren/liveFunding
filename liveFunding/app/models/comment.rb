class Comment < ActiveRecord::Base
  validates_presence_of :content, :commenter
  validates_length_of :commenter, :in => 2..15
  validates_length_of :content, :in => 2..2000
  belongs_to :user
  belongs_to :transaction
end
