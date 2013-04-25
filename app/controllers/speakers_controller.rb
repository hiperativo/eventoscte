class SpeakersController < ApplicationController
	def show
		@speaker = if params[:speaker_id]
			Speaker.find params[:speaker_id].delete("#")
		else 
			Speaker.find_by_name params[:speaker_name].gsub("_", " ")
		end
		render layout: false
	end
end