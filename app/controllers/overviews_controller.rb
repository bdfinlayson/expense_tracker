class OverviewsController < ApplicationController
  def index
    @total_expenses_this_month = current_user.expenses.where(created_at: Time.now.beginning_of_month..Time.now.end_of_month).pluck(:amount).sum
    @categories = current_user.categories.order(name: :asc)
    @total_for_month = current_user.budgets.pluck(:amount).sum
    @total_spent = current_user.categories.map(&:summed_expenses).sum
  end
end
