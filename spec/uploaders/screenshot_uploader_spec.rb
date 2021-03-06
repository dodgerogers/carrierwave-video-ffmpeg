require 'spec_helper'
require 'carrierwave/test/matchers'
require "pathname"

describe ScreenshotUploader do
  include CarrierWave::Test::Matchers 
  
  before do
    ScreenshotUploader.enable_processing = true
    ScreenshotUploader.storage = :file
    @video = create(:video)
    @uploader = ScreenshotUploader.new(@video, :screenshot)
    @uploader.store!(File.open("#{Rails.root}/spec/fixtures/files/seven_iron.jpeg"))
  end
  
  after do 
    ScreenshotUploader.enable_processing = false
    @uploader.remove!
  end
  
  context "taking a screenshot" do
    it "should take a screenshot of 200 x 100 pixels" do
      @uploader.should have_dimensions(200, 100)
    end
  end
  
  describe "cache_dir" do
    it "sets dir" do
      @uploader.cache_dir.should eq(Pathname.new("/Users/andrew/rails/teebox_network/public/uploads"))
    end
  end
  
  describe "extensions" do
    it "correct whitelist" do
      @uploader.extension_white_list.should eq(%w(jpg jpeg png))
      end
    end
    
  describe "store_dir" do
    it "allocates path to uploads" do
      @uploader.store_dir.should eq("uploads/user/screenshot/#{@uploader.id}")
    end
  end  
  
  describe "delete_tmp_dir" do
    it "delete_tmp_dir if upload successful" do
      file = File.open("#{Rails.root}/spec/fixtures/files/seven_iron.jpeg")
      @uploader.delete_tmp_dir(file).should eq(nil)
    end
  end
end