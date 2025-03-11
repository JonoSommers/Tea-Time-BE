class SubscriptionTeaSerializer
  include JSONAPI::Serializer
  attributes :name, :description, :temperature, :brew_time
end
