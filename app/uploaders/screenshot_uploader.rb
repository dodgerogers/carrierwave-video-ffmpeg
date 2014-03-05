require 'carrierwave/processing/mini_magick'
class ScreenshotUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  
  before :store, :remember_cache_id
  after :store, :delete_tmp_dir

  storage :fog
  
  process resize_and_pad: [200, 100, "#000", "Center"]

  def cache_dir
    Rails.root.join('public/uploads') 
  end
    
  def remember_cache_id(new_file)
    @cache_id_was = cache_id
  end

  def delete_tmp_dir(new_file)
    if @cache_id_was.present? && @cache_id_was =~ /\A[\d]{8}\-[\d]{4}\-[\d]+\-[\d]{4}\z/
      FileUtils.rm_rf(File.join(root, cache_dir, @cache_id_was))
    end
  end

  def extension_white_list
    %w(jpg jpeg png)
  end
  
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
