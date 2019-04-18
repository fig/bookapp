class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  # before_action :find_actions
  before_action :owned_article, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit]
  impressionist :actions=>[:show,:index]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.most_recent.limit(5)
    @announcements = Announcement.most_recent.limit(5)
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    impressionist(@article)
    @articles = Article.most_recent.limit(5)
    @announcements = Announcement.most_recent.limit(5)
  end

  # GET /articles/new
  def new
    @article = current_user.articles.build
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = current_user.articles.build(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :content, :user_id, :slug, :image)
    end

    # def find_actions
    #   @most_viewed = Article.order('impressions_count DESC').take(5)
    # end

    def owned_article
      unless current_user == @article.user
        flash[:alert] = "That article doesn't belong to you buddy D:!"
        redirect_to root_path
      end
    end
end
