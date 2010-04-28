require 'test_helper'

class EntityTest < ActiveSupport::TestCase
  test "invalid with empty attributes" do
    entity = Entity.new
    assert !entity.valid?
    assert entity.errors.invalid?(:name)
    assert entity.errors.invalid?(:phone_number)
    assert entity.errors.invalid?(:description)
    assert entity.errors.invalid?(:email)
    entity.is_organization = false
    assert !entity.errors.invalid?(:leader)
  end
  
  test "email format test" do
    entity = Entity.new(:name => "EU",
                        :is_organization => true,
                        :phone_number => 1234567,
                        :description => "XXXX",
                        :leader => "XX",
                        :email => "abc@xx.eu")
                        
    assert entity.valid?
    
    entity.email = "abc"
    assert !entity.errors.invalid?(:email)
   
  end  
  
  test "invalid with empty leader" do
    entity = Entity.new
    assert !entity.valid?
    assert entity.errors.invalid?(:name)
    assert entity.errors.invalid?(:phone_number)
    assert entity.errors.invalid?(:description)
    assert entity.errors.invalid?(:email)
    entity.is_organization = true
    assert !entity.errors.invalid?(:leader)
  end
  
end
