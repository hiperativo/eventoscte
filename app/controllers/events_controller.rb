class EventsController < ApplicationController
	def index
		@eventos = Event.all
	end
	def show
		@event = Event.find(params[:id])
	end
end