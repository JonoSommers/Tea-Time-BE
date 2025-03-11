class SubscriptionCustomerSerializer
  include JSONAPI::Serializer
  attributes :subscription_id, :customer_id, :status
end
