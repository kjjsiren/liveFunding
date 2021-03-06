#Transactions models the monetary relationships between different entieties in the system. Each transaction has an amounnt, a creator,
#a recipient, a donor, a information source and it can have multiple comments discussing the transaction.
class Transaction < ActiveRecord::Base
  has_many :comments
  belongs_to :donor, :class_name => 'Entity'
  belongs_to :recipient, :class_name => 'Entity'
  belongs_to :creator, :class_name => 'User'
  has_and_belongs_to_many :users, :uniq => true
  has_one :information_source
  named_scope :latest, lambda { |amount|
      {:limit => amount}
    }
  validate :amount_must_be_positive
  validates_presence_of :recipient, :donor # Recipient and donor can't be empty
  validates_numericality_of :amount	
  
  # Three way to rank the transactions, according to the rank,amount and time
  
  def self.top
    self.find(:all, :order => 'rank DESC', :limit => 10) 
  end
      
  def self.fundtop
    self.find(:all, :order => 'amount DESC', :limit => 10)
  end
  
  def self.newsfeed
    self.find(:all, :order => 'created_at DESC', :limit => 10)
  end
  
  protected
      def amount_must_be_positive
        errors.add(:amount, I18n.t('transactions.information.positive_amount')) if amount.nil? || amount < 0
      end
end

