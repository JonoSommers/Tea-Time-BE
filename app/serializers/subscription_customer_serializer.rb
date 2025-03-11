class SubscriptionCustomerSerializer
  include JSONAPI::Serializer
  belongs_to :subscription
  belongs_to :customer
end
