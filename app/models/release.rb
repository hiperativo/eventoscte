class Release < ActiveRecord::Base
  attr_accessible :contents, :image, :lead, :title
  mount_uploader :image, ReleaseImageUploader
end
