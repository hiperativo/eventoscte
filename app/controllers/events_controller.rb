class EventsController < ApplicationController
	def index
		@eventos = Event.order("date ASC")
	end
	def show
		@event = Event.find(params[:id])
	end
end