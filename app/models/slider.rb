class Slider < ActiveRecord::Base
  attr_accessible :description, :image, :image_cache, :link, :title, :remove_image
  mount_uploader :image, SliderUploader
end
