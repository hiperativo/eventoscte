class Photo < ActiveRecord::Base
<<<<<<< HEAD
	default_scope lambda { order :created_at }
=======
	default_scope lambda { order :position }

>>>>>>> 7bdae3c8c6ad2423a9293fd5fb6b8d52846585ae
	paginates_per 7
	attr_accessible :image, :event_id, :image_cache, :remove_image, :position
	belongs_to :event
	mount_uploader :image, PhotoUploader

	validates :image, presence: { message: "Envie uma imagem (ou apague a foto completamente)" }
end
