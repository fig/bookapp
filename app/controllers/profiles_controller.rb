class ProfilesController < ApplicationController
	before_action :find_user
	before_action :owned_profile, only: [:edit, :update]
	before_action :authenticate_user!
	impressionist :actions=>[:show,:index]

	def show
		@books = @user.books.order('created_at DESC')
		impressionist(@user)
	end

	def edit
	end

	def update
 		if @user.update(profile_params)
 			flash[:success] = 'Your profile has been updated.'
 			redirect_to profile_path(@user.username)
 		else
 			@user.errors.full_messages
 			flash[:error] = @user.errors.full_messages
 			render :edit
 		end
	end

	def user_interests
	    @my_interests = @user.tag_ids
	    @interests = Story.select { |s| (s.tag_ids & @my_interests).any? }
	end

	def following
		@following = @user.followers
	end

	def followers
		@followers = @user.following
	end

	private

	def profile_params
 		params.require(:user).permit(:avatar, :cover_image, :bio, tag_ids: [])
	end

	def find_user
 		@user = User.find_by(username: params[:username])
	end

	def owned_profile
		@user = User.find_by(username: params[:username])
		unless current_user == @user
			flash[:alert] = "That profile does not belong to you"
			redirect_to root_path
		end
	end
end
