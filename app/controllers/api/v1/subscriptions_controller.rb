class Api::V1::SubscriptionsController < ApplicationController
    def index
        render json: SubscriptionSerializer.new(Subscription.all), status: :ok
    end
end