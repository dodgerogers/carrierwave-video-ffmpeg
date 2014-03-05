class Video < ActiveRecord::Base
  attr_accessible :file, :screenshot, :filename
  
  mount_uploader :file, VideoUploader
  mount_uploader :screenshot, ScreenshotUploader
  before_save :create_filename
  
  def create_filename
    self.filename = File.basename(self.file.url, File.extname(self.file.url)).humanize
  end
  
  def take_screenshot
    location = "#{Rails.root}/public/uploads/tmp/screenshots/#{self.id}_#{File.basename(self.file.url)}.jpg"
    if self.file.url.include? "http://#{CONFIG[:s3_bucket]}.s3.amazonaws.com/"
      movie = FFMPEG::Movie.new(self.file.url)
      self.screenshot = movie.screenshot(location, {seek_time: 1, resolution: "200x100"}, preserve_aspect_ratio: :width)
      File.delete(location) if self.save!
    end
  end
end
