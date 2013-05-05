class Video < ActiveRecord::Base
	paginates_per 7
	attr_accessible :event_id, :youtube_url
	belongs_to :event
	before_save :extract_youtube_code_from_url
	

	attr_accessor :thumbnail

	def extract_youtube_code_from_url
		self.youtube_code = CGI.parse(URI.parse(self.youtube_url).query)['v'].first
	end

	def thumbnail(size)
		case size
			when :thumb then 	"http://img.youtube.com/vi/#{self.youtube_code}/default.jpg"
			when :small then 	"http://img.youtube.com/vi/#{self.youtube_code}/hqdefault.jpg"
			when :medium then 	"http://img.youtube.com/vi/#{self.youtube_code}/mqdefault.jpg"
			when :big then 		"http://img.youtube.com/vi/#{self.youtube_code}/maxresdefault.jpg"
		end
	end

end