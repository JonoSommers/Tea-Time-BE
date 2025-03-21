class SubscriptionCustomer < ApplicationRecord
    belongs_to :subscription
    belongs_to :customer

    validates :subscription_id, presence: true
    validates :customer_id, presence: true
    validates :status, inclusion: { in: [true, false] }

    def self.update_status(customer_id, subscription, subscription_customer)
        if subscription_customer
            new_status = !subscription_customer.status
            subscription_customer.update!(status: new_status)
            active_subscribers = subscription.subscription_customers.where(status: true).count
            subscription.update!(users_subscribed: active_subscribers)
        else
            subscription_customer = subscription.subscription_customers.create!(
                customer_id: customer_id, 
                status: true
            )
        end
        subscription_customer
    end
end