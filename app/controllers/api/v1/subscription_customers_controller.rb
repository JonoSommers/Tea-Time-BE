class Api::V1::SubscriptionCustomersController < ApplicationController
    def update
        subscription = Subscription.find(params[:subscription_id])
        subscription_customer = subscription.subscription_customers.find_by(customer_id: params[:customer_id])
        updated_sc = SubscriptionCustomer.update_status(params[:customer_id], subscription, subscription_customer)
        render json: { 
            subscription: SubscriptionSerializer.new(subscription),
            subscription_customer: SubscriptionCustomerSerializer.new(updated_sc)
        }
    end
end