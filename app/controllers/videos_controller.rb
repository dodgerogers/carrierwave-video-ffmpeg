class VideosController < ApplicationController

  def show
    @video = Video.find(params[:id])
  end

  def index
    @videos = Video.order("created_at desc")
    @video = Video.new
  end

  def create
    @video = Video.create(params[:video])
    respond_to do |format|
      if @video.save
        @video.take_screenshot # => optional @video.delay.screenshot
        format.html { redirect_to videos_path, notice: "Video created" }
        format.js
      else
        format.html { redirect_to videos_path, notice: "Failed to upload video" }
        format.js
      end
    end
  end
    
  def destroy
    @video = Video.find(params[:id]).destroy
    respond_to do |format|
      #format.html { redirect_to videos_path }
      format.js
    end
  end
end
