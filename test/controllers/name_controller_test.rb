require 'test_helper'

class NameControllerTest < ActionDispatch::IntegrationTest
  test "should get MoviesController" do
    get name_MoviesController_url
    assert_response :success
  end

end
