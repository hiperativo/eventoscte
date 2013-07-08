class Panel < ActiveRecord::Base
	attr_accessible :starts_at, :title, :after, :ordem, :starts_at
	belongs_to :event
	has_many :talks

	attr_accessible :talk_ids

	def short_time
		unless self.starts_at.nil?
			"#{self.starts_at.strftime("%k")}h#{self.starts_at.strftime("%M") if self.starts_at.strftime("%M").to_i > 0}"
		end
	end

end
