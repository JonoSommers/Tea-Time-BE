class SubscriptionTea < ApplicationRecord
    belongs_to :subsccription
    belongs_to :tea

    validates :subsccription_id, presence: true
    validates :tea_id, presence: true
end