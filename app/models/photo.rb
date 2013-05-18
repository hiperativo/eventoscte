class Photo < ActiveRecord::Base
	default_scope lambda { order :created_at }
	paginates_per 7
	attr_accessible :image, :event_id, :image_cache, :remove_image
	belongs_to :event
	mount_uploader :image, PhotoUploader

	validates :image, presence: { message: "Envie uma imagem (ou apague a foto completamente)" }
end
