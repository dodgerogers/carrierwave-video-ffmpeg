require "spec_helper"

describe VideosController do
  before(:each) do
    @video = create(:video)
    @video.stub!(:file).and_return("http://#{CONFIG[:s3_bucket]}.s3.amazonaws.com/uploads/video/file/22120817-19bf-40ec-96f1-3c904772370b/3-wood-creamed.m4v")
    @video.stub!(:screenshot).and_return("https://#{CONFIG[:s3_bucket]}.s3.amazonaws.com/uploads/video/screenshot/73/3-wood-creamed.m4v.jpg")
  end
  
  describe "GET show" do
   it "assigns a new video as @video" do
      @video = create(:video)
      get :show, id: @video
      assigns(:video).should eq(@video)
    end
    
    it "renders the show template" do
      @video = create(:video)
      get :show, id: @video
      response.should render_template :show
    end
  end
  
  describe "GET index" do
    it "renders index template" do
      get :index
      response.should render_template :index
    end
  end
end