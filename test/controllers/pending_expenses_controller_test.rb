require 'test_helper'

class PendingExpensesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pending_expenses_index_url
    assert_response :success
  end

end
