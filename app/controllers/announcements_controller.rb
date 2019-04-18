class AnnouncementsController < ApplicationController
  before_action :set_announcement, only: [:show, :edit, :update, :destroy]
  before_action :owned_announcement, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit]
  impressionist :actions=>[:show,:index]

  # GET /announcements
  # GET /announcements.json
  def index
    @announcements = Announcement.most_recent.page params[:page]
    @articles = Article.most_recent.limit(5)
  end

  # GET /announcements/1
  # GET /announcements/1.json
  def show
    impressionist(@announcement)
    @announcements = Announcement.most_recent
    @articles = Article.most_recent.limit(5)
  end

  # GET /announcements/new
  def new
    @announcement = current_user.announcements.build
  end

  # GET /announcements/1/edit
  def edit
  end

  # POST /announcements
  # POST /announcements.json
  def create
    @announcement = current_user.announcements.build(announcement_params)

    respond_to do |format|
      if @announcement.save
        format.html { redirect_to @announcement, notice: 'Announcement was successfully created.' }
        format.json { render :show, status: :created, location: @announcement }
      else
        format.html { render :new }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /announcements/1
  # PATCH/PUT /announcements/1.json
  def update
    respond_to do |format|
      if @announcement.update(announcement_params)
        format.html { redirect_to @announcement, notice: 'Announcement was successfully updated.' }
        format.json { render :show, status: :ok, location: @announcement }
      else
        format.html { render :edit }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /announcements/1
  # DELETE /announcements/1.json
  def destroy
    @announcement.destroy
    respond_to do |format|
      format.html { redirect_to announcements_url, notice: 'Announcement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_announcement
      @announcement = Announcement.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def announcement_params
      params.require(:announcement).permit(:title, :content, :user_id, :slug)
    end

    def owned_announcement
      unless current_user == @announcement.user
        flash[:alert] = "That announcement doesn't belong to you buddy D:!"
        redirect_to root_path
      end
    end
end
