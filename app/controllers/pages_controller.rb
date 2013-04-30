class PagesController < ApplicationController
	def index
		@sliders = Slider.all
		@supporters = Supporter.all
	end

	def local
	end

	def sponsors
		@supporters = Supporter.all
	end
end
