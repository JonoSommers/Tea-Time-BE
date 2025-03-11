FactoryBot.define do
    factory :subscription_customer do
        association :customer
        association :subscription
        status { [true, false].sample }
    end
end