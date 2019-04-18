class Review < ApplicationRecord
    belongs_to :book, counter_cache: true
    belongs_to :user

    validates :comment, presence: true
    validates :rating, presence: true

    scope :most_recent, -> { order(created_at: :desc) }

    after_commit :create_notifications, on: :create

    private

    def create_notifications
        Notification.create do |notification|
            notification.notify_type = 'new_review'
            notification.actor = self.user
            notification.user = self.book.user
            notification.target = self
            notification.second_target = self.book
        end
    end
end
