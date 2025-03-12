require 'rails_helper'

RSpec.describe SubscriptionCustomer, type: :model do

    describe 'validations' do
        it { should validate_presence_of(:subscription_id) }
        it { should validate_presence_of(:customer_id) }
    end

    describe 'associations' do
        it { should belong_to(:subscription) }
        it { should belong_to(:customer) }
    end

    before :each do
        @subscription = FactoryBot.create(:subscription)
        @customer = FactoryBot.create(:customer)
    end

    describe 'self.update_status' do
        it 'toggles the status and updates users_subscribed' do
            subscription_customer = FactoryBot.create(:subscription_customer, subscription: @subscription, customer: @customer, status: true)
            SubscriptionCustomer.update_status(@customer.id, @subscription, subscription_customer)
            expect(subscription_customer.status).to eq(false)
            expect(@subscription.users_subscribed).to eq(0) 
        end

        it 'creates a new subscription_customer and updates users_subscribed' do
            new_subscription_customer = SubscriptionCustomer.find_by(customer_id: @customer.id, subscription_id: @subscription.id)
            expect(new_subscription_customer).to be(nil)
            new_subscription_customer = SubscriptionCustomer.update_status(@customer.id, @subscription, nil)
            expect(new_subscription_customer).to_not be(nil)
            expect(new_subscription_customer.customer_id).to eq(@customer.id)
            expect(new_subscription_customer.subscription_id).to eq(@subscription.id)
            expect(new_subscription_customer.status).to eq(true)
        end
    end
end