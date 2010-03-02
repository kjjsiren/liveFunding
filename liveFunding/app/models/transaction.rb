class Transaction < ActiveRecord::Base
  has_many :comments
  belongs_to :donor, :class_name => 'Entity'
  belongs_to :recipient, :class_name => 'Entity'
  
  named_scope :latest, lambda { |amount|
      {:limit => amount}
    }
  
  validates_presence_of :recipient, :donor
  validates_numericality_of :amount
  
  def self.top
    self.find(:all, :order => 'rank DESC', :limit => 10)
  end
      
  def self.fundtop
    self.find(:all, :order => 'amount DESC', :limit => 10)
  end
  
  def self.newsfeed
    self.find(:all, :order => 'created_at DESC', :limit => 10)
  end
    
  # only for test
  def self.increment_rank(transaction_id)
    
  end  
end

