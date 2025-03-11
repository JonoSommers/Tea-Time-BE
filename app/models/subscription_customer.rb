class SubscriptionCustomer < ApplicationRecord
    belongs_to :subsccription
    belongs_to :customer

    validates :subsccription_id, presence: true
    validates :customer_id, presence: true
    validates :status, inclustion: { in: [true, false] }
end