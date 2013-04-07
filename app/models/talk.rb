class Talk < ActiveRecord::Base
	attr_accessible :order, :speaker_id, :title, :panel_id, :additional_info, :starts_at
	belongs_to :speaker
	belongs_to :panel
	
	def short_time
		"#{self.starts_at.strftime("%k")}h#{self.starts_at.strftime("%M") if self.starts_at.strftime("%M").to_i > 0}"
	end

end
