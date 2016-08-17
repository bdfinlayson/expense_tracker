require 'test_helper'

class IncomeCategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get income_categories_index_url
    assert_response :success
  end

  test "should get new" do
    get income_categories_new_url
    assert_response :success
  end

end
