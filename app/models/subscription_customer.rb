class SubscriptionCustomer < ApplicationRecord
    belongs_to :subscription
    belongs_to :customer

    validates :subscription_id, presence: true
    validates :customer_id, presence: true
    validates :status, inclusion: { in: [true, false] }

    def self.update_status(customer_id, subscription)
        subscription_customer = subscription.subscription_customers.find_by(customer_id: customer_id)
        if subscription_customer
            subscription_customer.update(status: !subscription_customer.status)
        else
            subscription_customer = subscription.subscription_customers.create!(
                customer_id: params[:customer_id], 
                status: true
            )
        end
    end
end