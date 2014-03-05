FactoryGirl.define do
  factory :video do
    screenshot "https://#{CONFIG[:s3_bucket]}.s3.amazonaws.com/uploads/video/screenshot/73/3-wood-creamed.m4v.jpg"
    file "http://#{CONFIG[:s3_bucket]}.s3.amazonaws.com/uploads/video/file/22120817-19bf-40ec-96f1-3c904772370b/3-wood-creamed.m4v"
  end
end