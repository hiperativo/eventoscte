class Talk < ActiveRecord::Base
	attr_accessible :order, :speaker_id, :title, :panel_id,
	:additional_info, :starts_at, :after, :slides, :slides_cache, :remove_slides, :ordem, :slides_local_file, :get_slides


	belongs_to :speaker
	belongs_to :panel

	mount_uploader :slides, SlidesUploader

	def get_slides
		if self.slides_local_file.blank?
			if self.slides.url.blank?
				nil
			else
				self.slides.url
			end
		else
			"/assets/"+self.slides_local_file
		end
	end

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
