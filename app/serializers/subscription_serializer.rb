class SubscriptionSerializer
  include JSONAPI::Serializer
  attributes :name, :price, :description, :img, :users_subscribed

  attribute :customers, if: Proc.new { |subscription, params| params[:include_customers] == true } do |subscription|
    subscription.subscription_customers
      .includes(:customer)
      .where(subscription_customers: { status: [true, false] })
      .map do |subscription_customer|
        customer = subscription_customer.customer
        {
          id: customer.id,
          name: "#{customer.first_name} #{customer.last_name}",
          email: customer.email,
          status: subscription_customer.status
        }
      end
  end

  attribute :teas, if: Proc.new { |subscription, params| params[:include_teas] == true } do |subscription|
    subscription.subscription_teas
      .includes(:tea)
      .where(subscription_teas: { subscription_id: subscription.id })
      .map do |subscription_tea|
        tea = subscription_tea.tea
        {
          name: tea.name,
          description: tea.description,
          temperature: tea.temperature,
          brew_time: tea.brew_time
        }
      end
  end

  attribute :joins_records, if: Proc.new { |subscription, params| params[:include_joins] == true } do |subscription|
    subscription.subscription_customers
      .includes(:subscription)
      .where(subscription_customers: { subscription_id: subscription.id })
      .map do |subscription_customer|
        {
          id: subscription_customer.id,
          customer_id: subscription_customer.customer_id,
          subscription_id: subscription_customer.subscription_id,
          status: subscription_customer.status
        }
      end
  end
end
