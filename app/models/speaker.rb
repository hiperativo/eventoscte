class Speaker < ActiveRecord::Base
	scope :with_bio, lambda { where("length(bio) > 0")}
	attr_accessible :avatar, :avatar_cache, :remove_avatar, :bio, :name, :ocupation
	has_many :talks
	# has_and_belongs_to_many :events
	mount_uploader :avatar, AvatarUploader
end
