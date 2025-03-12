FactoryBot.define do
    factory :subscription do
        sequence(:name) { |n| ["Green Tea", "Matcha Tea", "Earl Grey", "Oolong Tea", "Black Tea", "White Tea", "Pu-erh Tea", "Herbal Tea", "Chai Tea"][n % 9] }
        price { rand(20..50).round(2) }
        description { "A 3 pack variety of #{name}s deliverd directly to your door every month." }
        users_subscribed { 0 }
        img { "sample_image_url.jpg" }
    end
end