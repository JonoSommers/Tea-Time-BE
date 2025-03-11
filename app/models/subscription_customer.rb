class SubscriptionCustomer < ApplicationRecord
    belongs_to :subscription
    belongs_to :customer

    validates :subscription_id, presence: true
    validates :customer_id, presence: true
    validates :status, inclusion: { in: [true, false] }
end