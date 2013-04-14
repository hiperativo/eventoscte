require 'spec_helper'
describe "navigation through the site" do
	pages = %w"agenda-produtiva eventos inscreva-se local imprensa patrocinadores #"
	for page in pages do
		it("renders correctly #{page}"){ visit "/"+page }
	end

end