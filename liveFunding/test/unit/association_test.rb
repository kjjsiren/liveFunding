require 'test_helper'

class AssociationTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "invalid with empty attributes" do
    association = Association.new
    assert !association.valid?
    assert association.errors.invalid?(:description)
    assert association.errors.invalid?(:infosource)
  end
  
  test "association new test" do
    association = Association.new(:infosource => "nowhere",
                          :description => "not trustful")
                          
    assert association.valid?
    
  end
  
end
