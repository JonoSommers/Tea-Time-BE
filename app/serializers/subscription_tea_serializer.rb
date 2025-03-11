class SubscriptionTeaSerializer
  include JSONAPI::Serializer
  belongs_to :subscription
  belongs_to :tea 
end
