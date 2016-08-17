require 'test_helper'

class RecurringExpensesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get recurring_expenses_index_url
    assert_response :success
  end

  test "should get new" do
    get recurring_expenses_new_url
    assert_response :success
  end

end
