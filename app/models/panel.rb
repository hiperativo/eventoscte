class Panel < ActiveRecord::Base
	attr_accessible :event_id, :starts_at, :title, :after, :order
	belongs_to :event
	has_many :talks
end
