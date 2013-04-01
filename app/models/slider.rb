class Slider < ActiveRecord::Base
  attr_accessible :description, :image, :image_cache, :link, :title
  mount_uploader :image, SliderUploader
end
