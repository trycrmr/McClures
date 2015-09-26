require 'test_helper'

class PoliticianControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

end
