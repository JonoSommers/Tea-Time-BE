class SubscriptionSerializer
  include JSONAPI::Serializer
  attributes :name, :price, :description, :users_subscribed
end
