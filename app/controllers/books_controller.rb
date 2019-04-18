class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :owned_book, only: [:edit, :update, :destroy]
  before_action :find_chapter
  before_action :find_genre
  before_action :find_rating
  before_action :find_actions, only: [:index, :show]
  before_action :authenticate_user!, only: [:new, :edit, :saved_books]
  impressionist :actions=>[:show,:index]
  # respond_to :js, :json, :html

  def index
    if params[:genre].blank? && params[:rating].blank?
      @books = Book.paginate(page: params[:page])
      @articles = Article.most_recent.limit(5)
      @announcements = Announcement.most_recent.limit(5)
    else
      @genre = Genre.find_by(name: params[:genre])
      @rating = Rating.find_by(name: params[:rating])
      @books = Book.where(:genre_id => @genre_id).most_recent.paginate(page: params[:page])
      @books = Book.where(:rating_id => @rating_id).most_recent.paginate(page: params[:page])
      @books = Book.most_recent.paginate(page: params[:page])
      @articles = Article.most_recent.limit(5)
      @announcements = Announcement.most_recent.limit(5)
    end
  end

  # def index
  #   @books = Book.of_followed_users(current_user.following).order('created_at DESC').page params[:page]
  # end

  def show
    impressionist(@book)
    @most_viewed = Book.order('impressions_count DESC').take(6)
    @books = Book.most_recent.limit(3).reject { |b| b.id == @book.id }
    @articles = Article.most_recent.limit(5)
    @announcements = Announcement.most_recent.limit(5)
    @ratings = Rating.most_recent.limit(5)
    if @book.reviews.blank?
      @average_review = 0
    else
      @average_review = @book.reviews.average(:rating).round(2)
    end
    if user_signed_in?
      @message_has_been_sent = conversation_exist?
    end
  end

  def new
    @book = current_user.books.build
    @genres = Genre.all.map{ |g| [g.name, g.id] }
    @ratings = Rating.all.map{ |r| [r.name, r.id] }
  end

  def edit
    @genres = Genre.all.map{ |g| [g.name, g.id] }
    @ratings = Rating.all.map{ |r| [r.name, r.id] }
  end

  def create
    @book = current_user.books.build(book_params)
    @book.genre_id = params[:genre_id]
    @book.rating_id = params[:rating_id]

    if @book.save
      redirect_to @book, notice: 'Book was successfully published.'
    else
      render :new 
    end
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: 'Book was successfully updated.'
    else
      render :edit 
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    if @book.destroy
      redirect_to books_url, notice: 'Book was successfully deleted.'
    end
  end

  def following
		@following = @user.followers.order("created_at desc")
	end

	def followers
		@followers = @user.following.order("created_at desc")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.includes(:tags).friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :prologue, :copyright, :characters, :author, :user_id, :image, :genre_id, :rating_id, tag_ids: [])
    end

    def find_genre
      @books = Genre.where(:genre_id => @genre_id)
    end

    def find_rating
      @books = Rating.where(:rating_id => @rating_id)
    end

    def find_chapter
      @chapters = Chapter.friendly.where(book_id: @book).order("created_at desc")
    end

    def find_actions
      @most_viewed = Book.order('impressions_count DESC').take(6)
    end

    def owned_book
      unless current_user == @book.user
        flash[:alert] = "That book doesn't belong to you buddy D:!"
        redirect_to root_path
      end
    end

    def conversation_exist?
      Private::Conversation.between_users(current_user.id, @book.user.id).present?
    end
end
