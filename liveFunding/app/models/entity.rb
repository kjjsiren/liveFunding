class Entity < ActiveRecord::Base
	has_many :associations
	has_many :transactions
	has_many :donors, :through => :transactions
  has_many :recipients, :through => :transactions
  has_many :documentss
	has_attached_file :photo,
      :styles => {
        :thumb=> "100x100#",
        :small  => "150x150>",
        :medium => "300x300>",
        :large =>   "400x400>"}
	
	validates_presence_of :leader, :if => :is_organization;
	validates_presence_of :name, :email, :phone_number, :description
	validates_format_of :email, :with => /^(\w)+(\.\w+)*@(\w)+((\.\w{2,3}){1,3})$/;
end
