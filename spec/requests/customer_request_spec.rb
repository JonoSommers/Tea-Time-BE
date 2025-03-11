require 'rails_helper'

RSpec.describe 'Customer Controller', type: :request do
    before :each do
        customers = FactoryBot.create_list(:customer, 5)
        subscriptions = FactoryBot.create_list(:subscription, 3)

        customers.each do |customer|
            subscriptions.sample(2).each do |subscription|
                status = [true, false].sample
                FactoryBot.create(:subscription_customer, customer: customer, subscription: subscription, status: status)
            end
        end
    end

    describe 'GET /api/v1/customers' do
        it 'returns all customers and their data, including an array of their active subscriptions.' do
            get api_v1_customers_path
            expect(response).to be_successful
            expect(response.status).to eq(200)
            json = JSON.parse(response.body, symbolize_names: true)
            expect(json[:data]).to be_a Array
            expect(json[:data].count).to eq(5)
            expect(json[:data].first[:attributes]).to include(:first_name)
            expect(json[:data].first[:attributes]).to include(:last_name)
            expect(json[:data].first[:attributes]).to include(:email)
            expect(json[:data].first[:attributes]).to include(:address)
            expect(json[:data].first[:attributes]).to include(:subscriptions)
            expect(json[:data].first[:attributes][:subscriptions]).to be_a Array
            expect(json[:data].first[:attributes][:subscriptions].count).to be > 0
            expect(json[:data].first[:attributes][:subscriptions].first).to include(:id)
            expect(json[:data].first[:attributes][:subscriptions].first).to include(:name)
        end
    end
end