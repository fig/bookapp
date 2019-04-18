class TagsController < ApplicationController
  before_action :find_tag, only: [:edit, :update, :destroy, :show]

  def index
    @tags = Tag.all
    @articles = Article.most_recent.limit(5)
    @announcements = Announcement.most_recent.limit(5)
  end

  def new
    @tag = Tag.new
  end
    
  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      render json: @tag
    else
      render json: {errors: @tag.errors.full_messages}
  end
  end

  def show
    @tag = Tag.friendly.find(params[:id])
    @articles = Article.most_recent.limit(5)
    @announcements = Announcement.most_recent.limit(5)
  end

  def edit
  end

  def destroy
    @tag.destroy
    respond_to do |format|
      flash[:danger] = 'Tag was successfully deleted.' 
      format.html { redirect_to tags_url }
    end
  end

  def update
    respond_to do |format|
      if @tag.update(tag_params)
        flash[:success] = 'Tag was successfully updated.' 
        format.html { redirect_to @tag }
      else
        format.html { render :edit }
      end
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:name, :slug)
  end

  def find_tag
    @tag = Tag.friendly.find(params[:id])
  end
  
  def find_story
    @book = Book.includes(:tags).friendly.find(params[:story_id]) 
  end
  end