class PagesController < ApplicationController
	def index
		@sliders = Slider.all
	end
end
