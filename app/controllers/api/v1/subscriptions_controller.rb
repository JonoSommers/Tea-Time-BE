class Api::V1::SubscriptionsController < ApplicationController
    def index
        render json: SubscriptionSerializer.new(Subscription.all), status: :ok
    end

    def show
        subscription = Subscription.find(params[:id])
        render json: SubscriptionSerializer.new(subscription, { params: { include_customers: true, include_teas: true } }), status: :ok
    end
end