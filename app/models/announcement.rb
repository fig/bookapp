class Announcement < ApplicationRecord
    scope :most_recent, -> { order(created_at: :desc) }
    is_impressionable
    @most_viewed = Announcement.order('impressions_count DESC').limit(5)

    belongs_to :user

    extend FriendlyId
	friendly_id :title, use: :slugged
	
	def should_generate_new_friendly_id?
	  title_changed?
    end

    after_commit :create_notifications, on: :create

    private

    def create_notifications
        (User.all - [self.user]).each do |u|
          Notification.create(
            notify_type: 'new_announcement',
            actor: self.user,
            target: self,
            user_id: u.id
          )
        end
    end
end
