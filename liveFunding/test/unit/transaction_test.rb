require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  # test class for inputting transactions
  test "invalid with empty attributes" do
     transaction = Transaction.new
     assert !transaction.valid?
     assert transaction.errors.invalid?(:recipient)
     assert transaction.errors.invalid?(:donor)
     assert transaction.errors.invalid?(:amount)
    end
    
    
    test "valid attributes" do
      transaction = Transaction.new
      transaction.donor = Entity.first
      transaction.recipient = Entity.last
      transaction.amount = 300 
      assert transaction.valid?
      assert !transaction.errors.invalid?(:recipient)
      assert !transaction.errors.invalid?(:donor)
      assert !transaction.errors.invalid?(:amount)
      end
      
      test "invalid amount" do
        transaction = Transaction.new
        transaction.donor = Entity.first
        transaction.recipient = Entity.last
        transaction.amount = "kajdf" 
        assert !transaction.valid?
        assert !transaction.errors.invalid?(:recipient)
        assert !transaction.errors.invalid?(:donor)
        assert transaction.errors.invalid?(:amount)
        end
end
