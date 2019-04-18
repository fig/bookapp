class RatingsController < ApplicationController
  before_action :set_rating, only: [:show, :edit, :update, :destroy]
  before_action :find_book
  before_action :find_user
  impressionist :actions=>[:show,:index]
  before_action :authenticate_user!, only: [:new, :edit]

  def index
      @ratings = Rating.most_recent
  end

  def show
    impressionist(@rating)
    @articles = Article.most_recent.limit(5)
    @announcements = Announcement.most_recent.limit(5)
  end

  def new
    @rating = current_user.ratings.build
  end

  def edit
  end

  def create
    @rating = current_user.ratings.build(rating_params)

    respond_to do |format|
      if @rating.save
        flash[:success] = 'Your rating was successfully created.' 
        format.html { redirect_to @rating }
        format.json { render :show, status: :created, location: @rating }
      else
        format.html { render :new }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @rating.update(rating_params)
        flash[:success] = 'Your rating was successfully updated.' 
        format.html { redirect_to @rating }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @rating.destroy
    respond_to do |format|
      flash[:danger] = 'Your rating was successfully deleted.' 
      format.html { redirect_to ratings_url }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rating
      @rating = Rating.friendly.find(params[:id])
    end

    def find_user
      @user = User.find_by(name: params[:name])
    end

    def find_book
      @books = Book.friendly.where(rating_id: @rating).order("created_at desc")
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rating_params
      params.require(:rating).permit(:name, :description, :slug, :thumbnail)
    end

    # def find_actions
    #   @most_viewed = Story.order('impressions_count DESC').take(5)
    # end   
end
