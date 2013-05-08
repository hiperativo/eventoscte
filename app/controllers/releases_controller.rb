class ReleasesController < ApplicationController
	def index
		@events = Event.all
		@releases = @events.collect &:release_url
		@interviews = Interview.all
		@clippings = Clipping.all
	end
end
