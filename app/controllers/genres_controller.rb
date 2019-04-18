class GenresController < ApplicationController
  before_action :set_genre, only: [:show, :edit, :update, :destroy]
  before_action :find_book
  before_action :find_user
  impressionist :actions=>[:show,:index]
  before_action :authenticate_user!, only: [:new, :edit]

  def index
    @genres = Genre.most_recent
  end

  def show
    impressionist(@genre)
    @most_viewed = Book.order('impressions_count DESC').take(6)
    @articles = Article.most_recent.limit(5)
    @announcements = Announcement.most_recent.limit(5)
  end

  def new
    @genre = current_user.genres.build
  end

  def edit
  end

  def create
    @genre = current_user.genres.build(genre_params)

    respond_to do |format|
      if @genre.save
        flash[:success] = 'Your genre was successfully created.' 
        format.html { redirect_to @genre }
        format.json { render :show, status: :created, location: @genre }
      else
        format.html { render :new }
        format.json { render json: @genre.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @genre.update(genre_params)
        flash[:success] = 'Your genre was successfully updated.' 
        format.html { redirect_to @genre }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @genre.destroy
    respond_to do |format|
      flash[:danger] = 'Your genre was successfully deleted.' 
      format.html { redirect_to genres_url }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_genre
      @genre = Genre.friendly.find(params[:id])
    end

    def find_user
      @user = User.find_by(name: params[:name])
    end

    def find_book
      @books = Book.friendly.where(genre_id: @genre).order("created_at desc")
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def genre_params
      params.require(:genre).permit(:name, :description, :slug)
    end

    # def find_actions
    #   @most_viewed = Story.order('impressions_count DESC').take(5)
    # end   
end
