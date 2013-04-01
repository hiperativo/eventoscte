class Panel < ActiveRecord::Base
	attr_accessible :event_id, :starts_at, :title, :after
	belongs_to :event
	has_many :talks

	attr_accessor :stuff_before, :stuff_after, :short_time

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

	def short_time
		"#{self.starts_at.strftime("%k")}h#{self.starts_at.strftime("%M") if self.starts_at.strftime("%M").to_i > 0}"
	end

end
