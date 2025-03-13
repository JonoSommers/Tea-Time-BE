require 'rails_helper'

RSpec.describe 'Subscription Controller', type: :request do
    before :each do
        @subscriptions = FactoryBot.create_list(:subscription, 5)
        @customers = FactoryBot.create_list(:customer, 5)
        FactoryBot.create(:subscription_customer, customer: @customers.first, subscription: @subscriptions.first, status: true)
        FactoryBot.create(:subscription_customer, customer: @customers.last, subscription: @subscriptions.first, status: false)
        @teas = create_list(:tea, 3)
        @teas.each { |tea| create(:subscription_tea, subscription: @subscriptions.first, tea: tea) }
    end

    describe 'GET /api/v1/teas' do
        it 'returns all teas and their data.' do
            get api_v1_subscriptions_path
            expect(response).to be_successful
            expect(response.status).to eq(200)
            json = JSON.parse(response.body, symbolize_names: true)
            expect(json[:data]).to be_a Array
            expect(json[:data].count).to eq(5)
            expect(json[:data].first[:attributes]).to include(:name)
            expect(json[:data].first[:attributes]).to include(:price)
            expect(json[:data].first[:attributes]).to include(:description)
            expect(json[:data].first[:attributes]).to include(:img)
            expect(json[:data].first[:attributes]).to include(:users_subscribed)
        end
    end

    describe 'GET /api/v1/subscriptions/:id' do
        it 'returns all subscriptions and their data, including an additional customers attribute with name, email, and status.' do
            get api_v1_subscription_path(@subscriptions.first.id)
            expect(response).to be_successful
            expect(response.status).to eq(200)
            json = JSON.parse(response.body, symbolize_names: true)
            expect(json[:data]).to be_a Hash
            expect(json.count).to eq(1)
            expect(json[:data][:attributes]).to include(:name)
            expect(json[:data][:attributes]).to include(:price)
            expect(json[:data][:attributes]).to include(:description)
            expect(json[:data][:attributes]).to include(:img)
            expect(json[:data][:attributes]).to include(:users_subscribed)
            expect(json[:data][:attributes]).to include(:customers)
            expect(json[:data][:attributes]).to include(:joins_records)
            expect(json[:data][:attributes][:customers].count).to eq(2)
            expect(json[:data][:attributes][:customers].first).to include(:name)
            expect(json[:data][:attributes][:customers].first).to include(:email)
            expect(json[:data][:attributes][:customers].first).to include(:status)
            expect(json[:data][:attributes][:customers].last).to include(:name)
            expect(json[:data][:attributes][:customers].last).to include(:email)
            expect(json[:data][:attributes][:customers].last).to include(:status)
            expect(json[:data][:attributes][:customers].first[:email]).to eq(@customers.first.email)
            expect(json[:data][:attributes][:customers].last[:email]).to eq(@customers.last.email)
        end

        it 'returns all subscriptions and their data, including an additional teas attribute with name, description, temperature, and brew_time.' do
            get api_v1_subscription_path(@subscriptions.first.id)
            expect(response).to be_successful
            expect(response.status).to eq(200)
            json = JSON.parse(response.body, symbolize_names: true)
            expect(json[:data]).to be_a Hash
            expect(json.count).to eq(1)
            expect(json[:data][:attributes][:teas].count).to eq(3)
            expect(json[:data][:attributes][:teas].first).to include(:name)
            expect(json[:data][:attributes][:teas].first).to include(:description)
            expect(json[:data][:attributes][:teas].first).to include(:temperature)
            expect(json[:data][:attributes][:teas].last).to include(:brew_time)
            expect(json[:data][:attributes][:teas].first[:name]).to eq(@teas.first.name)
            expect(json[:data][:attributes][:teas].last[:name]).to eq(@teas.last.name)
        end

        it 'returns an empty customers array if no customers are (or have ever been) subscribed.' do
            get api_v1_subscription_path(@subscriptions.last.id)
            expect(response).to be_successful
            expect(response.status).to eq(200)
            json = JSON.parse(response.body, symbolize_names: true)
            expect(json[:data]).to be_a Hash
            expect(json.count).to eq(1)
            expect(json[:data][:attributes][:customers].count).to eq(0)
        end
    end
end