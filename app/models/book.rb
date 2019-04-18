class Book < ApplicationRecord

    self.per_page = 24

    scope :most_recent, -> { order(created_at: :desc) }
    is_impressionable :counter_cache => true
    @most_viewed = Book.order('impressions_count DESC').limit(5)

    belongs_to :user
    belongs_to :genre
    belongs_to :rating

    has_many :reviews, dependent: :destroy
    has_many :chapters, dependent: :destroy

    extend FriendlyId
	friendly_id :title, use: :slugged
	
	def should_generate_new_friendly_id?
	  title_changed?
    end

    has_many :taggings, dependent: :destroy
    has_many :tags, through: :taggings

    def related_books
        Book.joins(:tags).where(tags: { id: self.tags.pluck(:id) }).where.not(id: self.id)
    end

    has_one_attached :image

    after_commit :create_notifications, on: :create

    def create_notifications
        self.user.followers.each do |follower|
          Notification.create(notify_type: 'new_book', actor: self.user,
                              user: follower, target: self, second_target: self)
     
        end
    end
end
