class Chapter < ApplicationRecord
    belongs_to :book
    belongs_to :user

    has_many :comments, as: :commentable

    scope :most_recent, -> { order(created_at: :desc) }

    scope :most_old, -> { order(created_at: :asc) }
    
    extend FriendlyId
    friendly_id :title, use: :slugged
    
    def should_generate_new_friendly_id?
        title_changed?
    end

    extend FriendlyId
        friendly_id :title, use: :slugged
        
        def should_generate_new_friendly_id?
        title_changed?
    end
    
    is_impressionable

    after_commit :create_notifications, on: :create

    def create_notifications
        self.user.followers.each do |follower|
          Notification.create(notify_type: 'new_chapter', actor: self.book.user,
                              user: follower, target: self, second_target: self.book)
     
        end
    end
end
