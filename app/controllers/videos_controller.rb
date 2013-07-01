class VideosController < ApplicationController
	def index
		@event = Event.find(params[:event_id])
		params[:page] ||= 1
		@video = @event.videos.page(params[:page]).first
		redirect_to event_video_path(@event, @video, page: params[:page])
	end

	def show
		params[:page] = params[:page].to_i
		@evento = Event.find(params[:event_id])
		@event = Event.find(params[:event_id])
		@videos = @evento.videos.page(params[:page])
		@video = @videos.find(params[:id])
		@has_pagination = @videos.size > 7

		@gallery = {
			media: { 
				collection: @videos,
				type: :video,
				main: @video,
			},
			params: params
		}


		render layout: !request.xhr?
	end
end
