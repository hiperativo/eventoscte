class Photo < ActiveRecord::Base
	paginates_per 7
	attr_accessible :image, :event_id, :image_cache, :remove_image
	belongs_to :event
	mount_uploader :image, PhotoUploader

	validates :image, presence: { message: "Envie uma imagem (ou apague a foto completamente)"}
end
