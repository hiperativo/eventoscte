class PagesController < ApplicationController
	def index
		@sliders = Slider.all
	end

	def local
	end
end
