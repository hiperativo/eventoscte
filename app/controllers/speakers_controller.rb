class SpeakersController < ApplicationController
	def show
		@speaker = Speaker.find params[:speaker].delete("#")
		render layout: false
	end
end