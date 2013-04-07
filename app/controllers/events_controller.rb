class EventsController < ApplicationController
	def index
		@eventos = Event.where(disabled: false).order("date ASC")
	end
	def show
		@event = Event.find(params[:id])
	end
end