class PhotosController < ApplicationController
	def index
		@event = Event.find(params[:event_id])
		params[:page] ||= 1
		@photo = @event.photos.page(params[:page]).first
		redirect_to event_photo_path(@event, @photo, page: params[:page])
	end

	def show
		@evento = Event.find(params[:event_id])
		params[:page] = params[:page].to_i
		@photos = Photo.page(params[:page])
		@event = Event.find(params[:event_id])

		@photo = Photo.find(params[:id])

		@gallery = {
			media: { 
				collection: @photos,
				type: :photo,
				main: @photo,
			},
			params: params
		}

		render layout: !request.xhr?
	end
end
