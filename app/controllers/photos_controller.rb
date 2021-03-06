class PhotosController < ApplicationController
	def index
		@event = Event.find(params[:event_id])
		params[:page] ||= 1
		@photos = @event.photos
		@photo = @event.photos.page(params[:page]).first

		if current_admin_user
			render
		else 
			redirect_to event_photo_path(@event, @photo, page: params[:page])
		end
	end

	def show
		@evento = Event.find(params[:event_id])
		@event = Event.find(params[:event_id])
		params[:page] = params[:page].to_i
		@photos = @event.photos.page(params[:page])
		@photo = @event.photos.find(params[:id])

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

	def sort
		params[:photo].each_with_index do |photo, index|
			Photo.find(photo).update_attributes position: index
		end
		render text: "done"
	end

	def update
		Photo.find(params[:id]).update_attributes params[:photo]
		render status: :created, nothing: true
	end

end