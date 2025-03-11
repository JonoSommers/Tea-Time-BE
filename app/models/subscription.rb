class Subscription < ApplicationRecord
    has_many :subscription_teas
    has_many :teas, through: :subscription_teas
    has_many :subscription_customers
    has_many :customers, through: :subscription_customers

    validates :, presence: true
    validates :, presence: true, numericality: true
    validates :, presence: true
    validates :, presence: true, numericality: { only_integer: true}
end