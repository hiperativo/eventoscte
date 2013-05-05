class Panel < ActiveRecord::Base
	attr_accessible :starts_at, :title, :after, :order
	belongs_to :event
	has_many :talks

	attr_accessible :talk_ids
end
