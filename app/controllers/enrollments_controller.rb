class EnrollmentsController < ApplicationController
  def new
  	@enrollment = Enrollment.new
  end
end
