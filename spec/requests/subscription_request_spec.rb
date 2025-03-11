require 'rails_helper'

RSpec.describe 'Subscription Controller', type: :request do
    before :each do
        subscriptions = FactoryBot.create_list(:subscription, 5)
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
            expect(json[:data].first[:attributes]).to include(:users_subscribed)
        end
    end
end