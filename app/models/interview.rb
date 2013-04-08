class Interview < ActiveRecord::Base
  attr_accessible :image, :lead, :synopsis, :title, :contents, :remove_image, :image_cache
  mount_uploader :image, InterviewPhotoUploader
end