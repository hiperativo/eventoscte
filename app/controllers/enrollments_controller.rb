class EnrollmentsController < ApplicationController
  def new
  	@event = Event.where("date > ?", Time.now).order("date ASC").first
  	@enrollment = Enrollment.new
  	unless @event.nil? then @enrollment.event_id = @event.id end
  end

  def create
  	redirect_to "/"
  end
end
