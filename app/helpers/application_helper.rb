require 'navigation_helper.rb'

module ApplicationHelper
  include NavigationHelper
  include PostsHelper
  include Private::ConversationsHelper
  include Private::MessagesHelper 
  include Group::ConversationsHelper
  include Group::MessagesHelper

  def private_conversations_windows
    params[:controller] != 'messengers' ? @private_conversations_windows : []
  end

  def group_conversations_windows
    params[:controller] != 'messengers' ? @group_conversations_windows : []
  end

  def profile_avatar_select(user)  
  return image_tag user.avatar.variant(resize: '152x152'), id: 'image-preview', class: 'rounded-circle img-fluid profile-image profile-img', style: 'border: 1px solid grey' if user.avatar.attached?
    image_tag 'default-avatar.jpg', id: 'image-preview', class: 'img-responsive rounded-circle profile-image'
  end

  def profile_cover_select(user)  
    return image_tag user.cover_image, id: 'image-preview', class: '', style: '' if user.avatar.attached?
      image_tag 'book1.jpg', id: 'image-preview', class: 'img-responsive rounded-circle'
  end

  def current_user_avatar_select(user)  
    return image_tag current_user.avatar.variant(resize: '30x30'), id: 'image-preview', class: 'rounded-circle img-fluid current-user-image', style: 'border: 1px solid grey' if current_user.avatar.attached?
    image_tag 'default-avatar.jpg', id: 'image-preview', class: 'img-fluid rounded-circle current-user-image', style: "height: 30px; width 30px;"
  end

  def book_avatar_select(user)  
    return image_tag @book.user.avatar.variant(resize: '30x30'), id: 'image-preview', class: 'rounded-circle img-fluid book-user-image', style: 'border: 1px solid grey' if @book.user.avatar.attached?
    image_tag 'default-avatar.jpg', id: 'image-preview', class: 'rounded-circle img-fluid book-user-image', style: "width:30px; height:30px;"
  end

  def following_avatar_select(user)  
    return image_tag following.avatar.variant(resize: '30x30'), id: 'image-preview', class: 'rounded-circle img-fluid book-user-image', style: 'border: 1px solid grey' if following.avatar.attached?
    image_tag 'default-avatar.jpg', id: 'image-preview', class: 'rounded-circle img-fluid book-user-image', style: "width:30px; height:30px;"
  end

  def recipient_avatar_select(user)  
    return image_tag @recipient.avatar.variant(resize: '30x30'), id: 'image-preview', class: 'rounded-circle img-fluid current-user-image', style: 'border: 1px solid grey' if @recipient.avatar.attached?
    image_tag 'default-avatar.jpg', id: 'image-preview', class: 'img-fluid rounded-circle current-user-image', style: "height: 30px; width 30px;"
  end

  def find_actions
    @genres = Genre.all.order('created_at DESC')
    @ratings = Rating.all.order('created_at DESC')
    @announcements = Announcement.all.order('created_at DESC')
    @articles = Article.all.order('created_at DESC')
  end
end
