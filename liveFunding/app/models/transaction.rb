class Transaction < ActiveRecord::Base
  has_many :comments
  
  def self.top
    self.find(:all, :order => 'rank DESC', :limit => 10)
  end
end

