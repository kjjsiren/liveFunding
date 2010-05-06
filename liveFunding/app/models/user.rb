#User models the registered user in the system. Each registered user has a profile page which contains personal information, picture and
#transactions favorited by the user.
class User < ActiveRecord::Base
  require 'digest/sha1'
  has_attached_file :photo,
     :styles => {
       :thumb=> "100x100#",
       :small  => "150x150>",
       :medium => "300x300>",
       :large =>   "400x400>"}

  
  validates_length_of :username, :in => 3..15
  validates_length_of :firstname, :in => 3..50, :allow_blank => true
  validates_length_of :lastname, :in => 3..50, :allow_blank => true
  
  validates_length_of :password, :in => 5..30, :allow_blank => true, :on => :update
  validates_length_of :password, :in => 5..30, :on => :create
  validates_confirmation_of :password
  
  named_scope :with_email, :conditions => "email IS NOT NULL"
  
  has_many :transactions
  has_and_belongs_to_many :transactions, :uniq => true
  
  attr_accessor :password, :password_confirmation

  before_save :hash_password
 
  def self.authenticate(username, password)
    user = User.find_by_username(username)
    
    if user && user.hashed_password == hash_plaintext_password(password)
      return user
    else 
      return nil
     end 
  end
  
  private
  
  def hash_password
    return if self.password.blank?
    self.hashed_password = User.hash_plaintext_password(self.password)
  end
  
  def self.hash_plaintext_password(password)
    Digest::SHA1.hexdigest(password)
  end

   
end
