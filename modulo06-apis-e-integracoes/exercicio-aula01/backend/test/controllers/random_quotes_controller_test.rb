require "test_helper"

class RandomQuotesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get random_quotes_index_url
    assert_response :success
  end
end
