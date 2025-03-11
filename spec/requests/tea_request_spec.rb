require 'rails_helper'

RSpec.describe 'Tea Controller', type: :request do
    before :each do
        teas = FactoryBot.create_list(:tea, 5)
    end

    describe 'GET /api/v1/teas' do
        it 'returns all teas and their data.' do
            get api_v1_teas_path
            expect(response).to be_successful
            expect(response.status).to eq(200)
            json = JSON.parse(response.body, symbolize_names: true)
            expect(json[:data]).to be_a Array
            expect(json[:data].count).to eq(5)
            expect(json[:data].first[:attributes]).to include(:name)
            expect(json[:data].first[:attributes]).to include(:description)
            expect(json[:data].first[:attributes]).to include(:temperature)
            expect(json[:data].first[:attributes]).to include(:brew_time)
        end
    end
end