require "test_helper"

class QuoterControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get quoter_index_url
    assert_response :success
  end
end
