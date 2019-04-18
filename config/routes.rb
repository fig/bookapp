Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :announcements
  resources :articles
  mount Notifications::Engine => "/notifications"
  devise_for :users, :controllers => {:registrations => "registrations"}
  mount Comments::Engine => "/comments"

  get 'profiles/show'

  resources :genres
  resources :ratings

  resources :books do
    resources :chapters
    resources :reviews
    member do
      put "like" => "books#vote"
    end
  end

  resources :tags

  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
  end

  devise_scope :user do
    get 'sign_up', to: 'devise/registrations#new'
  end

  devise_scope :user do
    get 'sign_out', to: 'devise/sessions#destroy'
  end

  get 'messenger', to: 'messengers#index'
  get 'get_private_conversation', to: 'messengers#get_private_conversation'
  get 'get_group_conversation', to: 'messengers#get_group_conversation'
  get 'open_messenger', to: 'messengers#open_messenger'

  resources :posts do
    collection do
      get 'hobby'
      get 'study'
      get 'team'
    end
  end

  namespace :private do 
    resources :conversations, only: [:create] do
      member do
        post :close
        post :open
      end
    end
    resources :messages, only: [:index, :create]
  end

  namespace :group do 
    resources :conversations do
      member do
        post :close
        post :open
      end
    end
    resources :messages, only: [:index, :create]
  end

  resources :contacts, only: [:create, :update, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'home', to: 'home#index', as: :home
  root 'books#index'

  get ':username', to: 'profiles#show', as: :profile
 	get ':username/edit', to: 'profiles#edit', as: :edit_profile
  patch ':username/edit', to: 'profiles#update', as: :update_profile
   
  post ':username/follow_user', to: 'relationships#follow_user', as: :follow_user
  post ':username/unfollow_user', to: 'relationships#unfollow_user', as: :unfollow_user

  get ':username/followers', to: 'profiles#followers', as: :user_followers
  get ':username/following', to: 'profiles#following', as: :user_following

  get ':username/reviews', to: 'profiles#reviews', as: :user_reviews

end
