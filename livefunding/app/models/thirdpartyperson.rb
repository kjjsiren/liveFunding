class Thirdpartyperson < ActiveRecord::Base
	has_many :associations
		
	validates_presence_of :last_name, :first_name, :sex
	validates_numericality_of :phone_number
	
	end
