require 'rails_helper'

RSpec.describe SubscriptionCustomer, type: :model do

    describe 'validations' do
        it { should validate_presence_of(:subsccription_id) }
        it { should validate_presence_of(:customer_id) }
        it { should validate_presence_of(:status) }
    end

    describe 'associations' do
        it { should belong_to(:subscription) }
        it { should belong_to(:customer) }
    end
end