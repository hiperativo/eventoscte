class PhotosController < ApplicationController
	def index
		@event = Event.find(params[:event_id])
		@photo = @event.photos.first
		redirect_to event_photo_path(@event, @photo)
	end

	def show
		@event = Event.find(params[:event_id])
		
		@all_photos = Photo.all
		
		@photo = Photo.find(params[:id])
		@photo_index = @all_photos.index(@photo)+1
		
		params[:offset] = [@photo_index-7, 0].max
		
		@photos = Photo.limit(7).offset params[:offset]
		@has_pagination = (@all_photos.count > 7)

		@next_photo = @all_photos[ [@all_photos.count-1, params[:offset]+7 ].min]

		@previous_photo = @all_photos[ [params[:offset]-7, 0].max ]

		render layout: !request.xhr?
	end
end
