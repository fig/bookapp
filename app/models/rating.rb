class Rating < ApplicationRecord
    belongs_to :user
    has_many :books, dependent: :destroy

    has_one_attached :thumbnail

    scope :alphabetically, ->{ order "name asc" }

    scope :most_recent, -> { order(created_at: :desc) }

    extend FriendlyId
    friendly_id :name, use: :slugged

    def should_generate_new_friendly_id?
        name_changed?
    end

    is_impressionable
end
