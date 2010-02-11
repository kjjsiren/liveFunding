class Transaction < ActiveRecord::Base
  has_many :comments
  
  def self.top
    self.find(:all, :order => 'rank DESC', :limit => 10)
  end
  
  def self.increment_rank(transaction_id)
    
  end  
end

