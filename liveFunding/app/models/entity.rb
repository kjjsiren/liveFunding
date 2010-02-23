class Entity < ActiveRecord::Base
	has_many :associations
	validates_presence_of :leader, :if => :is_organization;
	validates_presence_of :name, :email, :phone_number, :description
	validates_format_of :email, :with => /^(\w)+(\.\w+)*@(\w)+((\.\w{2,3}){1,3})$/;
end
