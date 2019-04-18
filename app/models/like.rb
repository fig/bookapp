class Like < ApplicationRecord
    belongs_to :user
	belongs_to :story

	scope :most_recent, -> { order(created_at: :desc) }
end
