FactoryBot.define do
    factory :subscription do
        name { ["Green Tea", "Matcha Tea", "Earl Grey", "Oolong Tea", "Black Tea", "White Tea", "Pu-erh Tea", "Herbal Tea", "Chai Tea"].shift }
        price { rand(10..50).round(2) }
        description { "A 3 pack variety of #{name}s deliverd directly to your door every month." }
        users_subscribed { 0 }
    end
end