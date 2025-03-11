FactoryBot.define do
    factory :tea do
        tea_types = [
            "Sencha Green Tea", "Jasmine Green Tea", "Dragon Well (Longjing) Green Tea",
            "Ceremonial Matcha", "Culinary Matcha", "Organic Matcha",
            "Classic Earl Grey", "Earl Grey with Lavender", "Earl Grey with Bergamot",
            "Tie Guan Yin (Iron Goddess)", "Wuyi Rock Oolong", "Milk Oolong",
            "Darjeeling", "Assam Black Tea", "English Breakfast",
            "Silver Needle White Tea", "White Peony (Bai Mu Dan)", "Ceylon White Tea",
            "Raw (Sheng) Pu-erh", "Aged (Shou) Pu-erh", "Mini Tuo Cha Pu-erh",
            "Chamomile", "Peppermint", "Rooibos",
            "Masala Chai", "Vanilla Chai", "Spiced Chai"
        ]
        
        name { tea_types.shift }
        description { "A delicious type of tea." }
        temperature{ rand(180..201) }
        brew_time{ rand(3..5) }
    end
end