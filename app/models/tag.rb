class Tag < ApplicationRecord
    has_many :taggings
    has_many :books, through: :taggings
    
    scope :most_recent, -> { order(created_at: :desc) }

    extend FriendlyId
    friendly_id :name, use: :slugged

    def should_generate_new_friendly_id?
        name_changed?
    end
end
