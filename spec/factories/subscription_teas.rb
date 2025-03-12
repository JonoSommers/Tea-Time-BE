FactoryBot.define do
    factory :subscription_tea do
        subscription { association :subscription }
        tea { association :tea }
    end
end