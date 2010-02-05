class Transaction < ActiveRecord::Base
  
  def self.top
    self.find(:all, :order => 'rank DESC', :limit => 10)
  end
end

