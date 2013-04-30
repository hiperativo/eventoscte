class Supporter < ActiveRecord::Base
  attr_accessible :image, :name, :image_cache, :remove_image
  mount_uploader :image, SupporterLogoUploader

  default_scope order("name ASC")
end
