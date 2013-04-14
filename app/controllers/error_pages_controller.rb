class ErrorPagesController < ApplicationController

	def not_found
	end

	def server_error
	end

	def maintenance
		render layout: false
	end
end
