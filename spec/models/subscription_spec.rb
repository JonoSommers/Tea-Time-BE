require 'rails_helper'

RSpec.describe Subscription, type: :model do

    describe 'validations' do
        it { should validate_presence_of(:name) }
        it { should validate_presence_of(:price) }
        it { should validate_numericality_of(:price) }
        it { should validate_presence_of(:description) }
        it { should validate_presence_of(:users_subscribed) }
        it { should validate_numericality_of(:users_subscribed).only_integer }
    end

    describe 'associations' do
        it { should have_many(:subscription_teas) }
        it { should have_many(:teas).through(:subscription_teas) }
        it { should have_many(:subscription_customers) }
        it { should have_many(:customers).through(:subscription_customers) }
    end
end