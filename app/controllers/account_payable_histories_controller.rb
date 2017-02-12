class AccountPayableHistoriesController < ApplicationController
  def index
    @account = AccountPayable.find(params[:id])
    @logs = @account.logs.order(created_at: :desc)
    @total_items = @logs.count
    @columns = %w(date transaction_amount starting_amount ending_amount)
    @stats = {}
  end
end
