#Documents are attachments that belong to entities. An entity can have multiple documents.
class Documents < ActiveRecord::Base
  belongs_to :entity
end
