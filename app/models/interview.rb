class Interview < ActiveRecord::Base
  attr_accessible :image, :lead, :synopsis, :title, :contents, :remove_image, :image_cache, :event_id
  mount_uploader :image, InterviewPhotoUploader
  belongs_to :event
end