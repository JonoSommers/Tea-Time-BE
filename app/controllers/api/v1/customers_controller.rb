class Api::V1::CustomersController < ApplicationController

    def index
        render json: CustomerSerializer.new(Customer.all), status: :ok
    end
end