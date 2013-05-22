class EventsController < ApplicationController
	def index
		@eventos = Event.where(disabled: false).order("date ASC")
	end
	def show
		if params[:slug]
			@event = Event.find_by_slug params[:slug]
		else
			@event = Event.find params[:id]
		end
		@interviews = @event.interviews
	end
end