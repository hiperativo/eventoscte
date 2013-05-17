class Talk < ActiveRecord::Base
	attr_accessible :order, :speaker_id, :title, :panel_id,
	:additional_info, :starts_at, :after, :slides, :slides_cache, :remove_slides

	belongs_to :speaker
	belongs_to :panel
	mount_uploader :slides, SlidesUploader

	def short_time
		unless self.starts_at.nil?
			"#{self.starts_at.strftime("%k")}h#{self.starts_at.strftime("%M") if self.starts_at.strftime("%M").to_i > 0}"
		end
	end

  	def stuff_after
		self.split_stuff_that_happens :after
	end

	def split_stuff_that_happens what
		self[what].split("\n").map do |item|
			{ time: item.split(" - ")[0], what: item.split(" - ")[1] }
		end
	end

end
