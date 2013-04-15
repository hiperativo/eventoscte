require "spec_helper"

describe Enrollment do
	it "creates succesfully" do
		FactoryGirl.create :enrollment
	end
end