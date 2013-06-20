class InterviewsController < ApplicationController
  def show
  	@interview = Interview.find(params[:id])
  	@interviews = Interview.all
  end
end
