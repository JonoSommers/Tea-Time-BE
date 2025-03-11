class CustomerSerializer
  include JSONAPI::Serializer
  attributes :first_name, :last_name, :email, :address

  attribute :subscriptions do |customer|
    customer.subscription_customers
      .includes(:subscription)
      .where(subscription_customers: { status: true }) 
      .map do |subscription_customer|
        subscription = subscription_customer.subscription
        {
          id: subscription.id,
          name: subscription.name
        }
      end
  end
end