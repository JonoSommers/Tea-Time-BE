class SubscriptionSerializer
  include JSONAPI::Serializer
  attributes :name, :price, :description, :users_subscribed

  attribute :customers, if: Proc.new { |record, params| params[:include_customers] } do |subscription|
    subscription.subscription_customers
      .includes(:customer)
      .where(subscription_customers: { status: [true, false] })
      .map do |subscription_customer|
        customer = subscription_customer.customer
        {
          name: "#{customer.first_name} #{customer.last_name}",
          email: customer.email,
          status: subscription_customer.status
        }
      end
  end
end
