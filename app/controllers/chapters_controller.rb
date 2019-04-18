class ChaptersController < ApplicationController
	before_action :find_book
	before_action :find_user
	before_action :find_chapter, only: [:edit, :update, :destroy, :show]
	before_action :owned_book, only: [:edit, :update, :destroy]

	def new
		@chapter = current_user.chapters.build
	end

	# def index
	# 	@chapters = Chapter.all
	# end

	def show
		impressionist(@chapter)
		@most_viewed = Book.order('impressions_count DESC')
		@chapters = Chapter.where(book_id: @book).most_old.reject { |c| c.id == @chapter.id }
		# @saved_stories = current_user.saved_stories.order(created_at: :DESC)
		if @book.reviews.blank?
			@average_review = 0
		else
			@average_review = @book.reviews.average(:rating).round(2)
		end
	end

	def create
		@chapter = current_user.chapters.build(chapter_params)
		@chapter.book_id = @book.id
		@chapter.user_id = current_user.id

		if @chapter.save
			redirect_to book_chapter_path(@book, @chapter)
		else
			render 'new'
		end
	end

	def edit
	end

	def destroy
		@chapter.destroy
		redirect_to book_path(@book)
	end

	def update
		if @chapter.update(chapter_params)
			redirect_to book_chapter_path(@book, @chapter)
		else
			render 'edit'
		end
	end

	private

    def chapter_params
        params.require(:chapter).permit(:title, :content)
    end

    def find_book
        @book = Book.friendly.find(params[:book_id])
    end

    def find_genre
        @books = Book.where(:genre_id => @genre_id).order("created_at ASC")
    end

    def find_chapter
        @chapter = Chapter.friendly.find(params[:id])
    end

    def owned_book
        unless current_user == @book.user
            flash[:alert] = "That book doesn't belong to you!"
            redirect_to root_path
        end
	end
	
	def find_user
		@user = User.find_by(username: params[:username])
   	end

end