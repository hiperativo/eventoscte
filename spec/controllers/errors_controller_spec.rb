require 'spec_helper'

describe ErrorsController do

  describe "GET 'not_found'" do
    it "returns http success" do
      get 'not_found'
      response.should be_success
    end
  end

  describe "GET 'internal_error'" do
    it "returns http success" do
      get 'internal_error'
      response.should be_success
    end
  end

end
