class Speaker < ActiveRecord::Base
  attr_accessible :avatar, :avatar_cache, :remove_avatar, :bio, :name, :ocupation
  has_many :talks
  mount_uploader :avatar, AvatarUploader
end
