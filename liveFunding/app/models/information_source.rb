#Information source is linked to a transaction, in order for the users to rank the credibility of the transaction's source information.
#Each transaction has single source of information.
class InformationSource < ActiveRecord::Base
  belongs_to :transaction
end
