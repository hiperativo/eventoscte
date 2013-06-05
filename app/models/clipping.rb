class Clipping < ActiveRecord::Base

	default_scope lambda { order("created_at DESC") }
  attr_accessible :desc, :lead, :materia, :titulo, 
  :materia_cache, :remove_materia, :materia_link, 
  :image, :image_cache, :remove_image



  mount_uploader :materia, ClippingUploader
  mount_uploader :image, ClippingImageUploader
end
