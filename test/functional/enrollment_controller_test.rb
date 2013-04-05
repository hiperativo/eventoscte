require 'test_helper'

class EnrollmentControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

end
