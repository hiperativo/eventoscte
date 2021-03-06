class SpeakersController < ApplicationController
	def index
		@event = Event.find params[:event_id]
		@roberto = Speaker.where(name: "Roberto de Souza").first
		@speakers = @event.speakers.with_bio
		@speakers.unshift @roberto unless @roberto.nil?
	end

	def show
		@speaker = if params[:speaker_id]
			Speaker.find params[:speaker_id].delete("#")
		else 
			Speaker.find_by_name params[:speaker_name].gsub("_", " ")
		end
		render layout: false
	end
end