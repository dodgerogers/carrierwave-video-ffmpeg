require 'carrierwave/processing/mime_types'
 
class VideoUploader < CarrierWave::Uploader::Base
  include CarrierWave::Video
  include CarrierWave::MimeTypes
  
  process :set_content_type
  
  storage :fog
  
  process :encode
  def full_filename(for_file)
    "#{File.basename(for_file, File.extname(for_file))}.mp4"
  end
  
  def encode
    movie ||= FFMPEG::Movie.new(@file.path)
    aspect_ratio = movie.width.to_f / movie.height.to_f
    case movie.rotation
    when 90
      rotate = "-vf transpose=1"
      aspect_ratio = movie.height.to_f / movie.width.to_f
    when 180
      rotate = "-vf vflip,hflip"
    when 270
      rotate = "-vf transpose=2"
    else
      rotate = ""
    end
    encode_video("mp4", custom: rotate, aspect: aspect_ratio)
  end
  
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end