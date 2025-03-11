class Api::V1::SubscriptionCustomersController < ApplicationController
    def update
        subscription = Subscription.find(params[:subscription_id])
        SubscriptionCustomer.update_status(params[:customer_id], subscription)
        Subscription.update_users_subscribed(params[:subscription_id])
        render json: SubscriptionSerializer.new(subscription)
    end
end