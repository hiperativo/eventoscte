class Photo < ActiveRecord::Base
	default_scope lambda { order :position }
	paginates_per 7
	attr_accessible :image, :event_id, :image_cache, :remove_image, :position, :caption
	belongs_to :event
	mount_uploader :image, PhotoUploader

	validates :image, presence: { message: "Envie uma imagem (ou apague a foto completamente)" }
end
