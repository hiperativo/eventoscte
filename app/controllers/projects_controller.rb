class ProjectsController < ApplicationController
	before_action :authenticate_admin_user!, except: :index

	def index
		@projects = Project.order(:position)
	end

	def sort
		params[:project].each_with_index do |project, index|
			Project.find(project).update_attributes position: index
		end
		render text: "done"
	end

end
