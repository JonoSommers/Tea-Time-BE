require 'rails_helper'

RSpec.describe 'SubscriptionCustomers Controller', type: :request do
    before :each do
        @subscriptions = FactoryBot.create_list(:subscription, 5)
        @customers = FactoryBot.create_list(:customer, 5)
        @subscription_customer1 = FactoryBot.create(:subscription_customer, customer: @customers.first, subscription: @subscriptions.first, status: true)
        @subscription_customer2 = FactoryBot.create(:subscription_customer, customer: @customers.last, subscription: @subscriptions.first, status: false)
        @subscription_customer3 = FactoryBot.create(:subscription_customer, customer: @customers[2], subscription: @subscriptions.first, status: true)
        @subscription_customer4 = FactoryBot.create(:subscription_customer, customer: @customers[3], subscription: @subscriptions.first, status: true)
    end

    describe 'PATCH /api/v1/subscriptions/:subscription_id/subscription_customers/:id' do
        it 'returns updated subscription and subscription_customer data ' do
            patch api_v1_subscription_subscription_customer_path(@subscriptions.first.id, @subscription_customer1.id), params: { customer_id: @customers.first.id }
            expect(response).to be_successful
            expect(response.status).to eq(200)
            json = JSON.parse(response.body, symbolize_names: true)
            expect(json[:subscription][:data]).to be_a Hash
            expect(json[:subscription_customer][:data]).to be_a Hash
            expect(json.count).to eq(2)
            expect(json[:subscription][:data][:attributes]).to include(:name)
            expect(json[:subscription][:data][:attributes][:name]).to eq(@subscriptions.first.name)
            expect(json[:subscription][:data][:attributes]).to include(:price)
            expect(json[:subscription][:data][:attributes][:price]).to eq(@subscriptions.first.price)
            expect(json[:subscription][:data][:attributes]).to include(:description)
            expect(json[:subscription][:data][:attributes][:description]).to eq(@subscriptions.first.description)
            expect(json[:subscription][:data][:attributes]).to include(:users_subscribed)
            expect(json[:subscription][:data][:attributes][:users_subscribed]).to eq(2)
            expect(json[:subscription_customer][:data][:attributes]).to include(:subscription_id)
            expect(json[:subscription_customer][:data][:attributes][:subscription_id]).to eq(@subscriptions.first.id)
            expect(json[:subscription_customer][:data][:attributes]).to include(:customer_id)
            expect(json[:subscription_customer][:data][:attributes][:customer_id]).to eq(@customers.first.id)
            expect(json[:subscription_customer][:data][:attributes]).to include(:status)
            expect(json[:subscription_customer][:data][:attributes][:status]).to eq(!@subscription_customer1.status)
        end

        it 'creates a new record if the customer was/has not been subscribed to the subscription.' do
            patch api_v1_subscription_subscription_customer_path(@subscriptions.first.id, 999999999), params: { customer_id: @customers[1].id }
            expect(response).to be_successful
            expect(response.status).to eq(200)
            json = JSON.parse(response.body, symbolize_names: true)
            expect(json).not_to be_nil
            expect(json[:subscription_customer][:data][:attributes][:status]).to eq(true)
        end
    end

    describe 'Sad Paths for Update Status' do
        it 'returns a 422, Unprocessable_entity, error for an invlaid customer_id in the request body.' do
            patch api_v1_subscription_subscription_customer_path(@subscriptions.first.id, @subscription_customer1.id), params: { customer_id: 999 }
            expect(response).to have_http_status(:unprocessable_entity)
            json = JSON.parse(response.body, symbolize_names: true)
            expect(json[:error][:status]).to eq("422")
            expect(json[:error][:title]).to eq("Unprocessable_entity")
            expect(json[:error][:message]).to eq("Customer must exist")
        end

        it 'returns a 422, Unprocessable_entity, error for a blank request body.' do
            patch api_v1_subscription_subscription_customer_path(@subscriptions.first.id, @subscription_customer1.id), params: {}
            expect(response).to have_http_status(:unprocessable_entity)
            json = JSON.parse(response.body, symbolize_names: true)
            expect(json[:error][:status]).to eq("422")
            expect(json[:error][:title]).to eq("Unprocessable_entity")
            expect(json[:error][:message]).to eq("Customer must exist and Customer can't be blank")
        end

        it 'returns a 404, Record Not Found, error for an invalid subscription_id.' do
            patch api_v1_subscription_subscription_customer_path(99999, @subscription_customer1.id), params: { customer_id: @customers[1].id }
            expect(response).to have_http_status(:not_found)
            json = JSON.parse(response.body, symbolize_names: true)
            expect(json[:error][:status]).to eq("404")
            expect(json[:error][:title]).to eq("Record Not Found")
            expect(json[:error][:message]).to eq("Couldn't find Subscription with 'id'=99999")
        end
    end
end