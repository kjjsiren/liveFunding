require 'test_helper'

class ThirdpartypeopleTest < ActiveSupport::TestCase
  test "invalid with empty attributes" do
    tirdpartypeople = Thirdpartypeople.new
    assert !tirdpartypeople.valid?
    assert tirdpartypeople.errors.invalid?(:last_name)
	assert tirdpartypeople.errors.invalid?(:first_name)
    assert tirdpartypeople.errors.invalid?(:sex)
    assert tirdpartypeople.errors.invalid?(:phone_number)

  end
  
  test "email format test" do
    tirdpartypeople = Tirdpartypeoplenew(:last_name => "Kai",
                        :first_name = "Zhao"
                        :sex = "male"
                        :phone_number = 1234567
											)
                        
    assert tirdpartypeople.valid?
    
    thirdpartypeople.phone_number = "abc"
    assert !thirdypartypeople.errors.invalid?(:phone_number)
   
  end  
  
end
