class Event < ActiveRecord::Base
	attr_accessible :address, :banner, :banner_cache, :remove_banner, :contact_info, :description, :lead, :place, :target, :title, :when, :after, :before
	has_many :panels
	mount_uploader :banner, EventCoverUploader

	attr_accessor :stuff_before, :stuff_after

	def stuff_before
		self.split_stuff_that_happens :before
	end

	def stuff_after 
		self.split_stuff_that_happens :after
	end

	def split_stuff_that_happens what
		self[what].split("\n").map do |item|
			{ time: item.split(" ")[0], what: item.split(" ")[1] }
		end
	end

end
