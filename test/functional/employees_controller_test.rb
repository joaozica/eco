require 'test_helper'

class EmployeesControllerTest < ActionController::TestCase
  test "should get selection" do
    get :selection
    assert_response :success
  end

end
