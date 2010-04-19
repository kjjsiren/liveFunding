module EntitiesHelper

def moneySum(entity)
  @entity = Entity.find(entity)
  sum = Transaction.sum(:amount, :conditions=>["donor_id = #{@entity.id}"])
  sum += Transaction.sum(:amount, :conditions=>["recipient_id = #{@entity.id}"])
  return sum
end

def transactionsCount(entity)
  @entity = Entity.find(entity)
  count = Transaction.count(:all, :conditions=>["donor_id = #{@entity.id}"])
  count += Transaction.count(:all, :conditions=>["recipient_id = #{@entity.id}"])
  return count
end

end
