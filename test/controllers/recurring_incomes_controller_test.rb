require 'test_helper'

class RecurringIncomesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get recurring_incomes_index_url
    assert_response :success
  end

  test "should get new" do
    get recurring_incomes_new_url
    assert_response :success
  end

end
