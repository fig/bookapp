# Model from comments gem
class Comment < ActiveRecord::Base
  include Comments::Model

  belongs_to :commentable, polymorphic: true
  # belongs_to :chapter

  # after_commit :create_notifications, on: :create

  # private

  # def create_notifications
  #     Notification.create do |notification|
  #         notification.notify_type = 'new_comment'
  #         notification.actor = self.user
  #         notification.user = self.chapter.user
  #         notification.target = self
  #         notification.second_target = self.chapter
  #     end
  # end
end
