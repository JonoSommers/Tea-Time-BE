class Customer < ApplicationRecord
    has_many :subscription_customers
    has_many :subsccriptions, through: subscription_customers

    validates :first_name, presense: true
    validates :last_name, presense: true
    validates :email, presense: true, uniqueness: true
    validates :address, presense: true
end