require 'spec_helper'
describe "enrollments", type: :feature do
	it "enrolls successfully" do
		user = FactoryGirl.build :enrollment

		# visit "/inscricoes/nova"
		# fill_in "enrollment[full_name]", with: user.full_name
		# fill_in "enrollment[display_name]", with: user.display_name
		# fill_in "enrollment[email]", with: user.email
		# fill_in "enrollment[enterprise]", with: user.enterprise
		# fill_in "enrollment[profession]", with: user.profession
		# fill_in "enrollment[occupation]", with: user.occupation
		# fill_in "enrollment[category]", with: user.category
		# # page.fill_in "display_name", with: user.full_name
	end
end