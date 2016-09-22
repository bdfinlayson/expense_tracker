class OverviewsController < ApplicationController
  respond_to :json, :html

  def index
    @total_expenses_this_month = current_user.expenses.where(created_at: Time.now.beginning_of_month..Time.now.end_of_month).pluck(:amount).sum
    @monthly_expenses_chart = get_monthly_expense_history
    @monthly_income_history = get_monthly_income_history
    @monthly_profit_history = get_monthly_profit_history(@monthly_expenses_chart.values, @monthly_income_history.values)
    @income_this_month = current_user.incomes.where(created_at: Time.now.beginning_of_month..Time.now.end_of_month).pluck(:amount).sum
    @categories = current_user.expense_categories.order('lower(name) asc')
    @total_for_month = current_user.budgets.pluck(:amount).sum
    @total_spent = current_user.expense_categories.map(&:summed_expenses).sum
    @net_worth_for_month = @income_this_month - @total_expenses_this_month
  end

  def data
    expenses = get_monthly_expense_history.values
    incomes = get_monthly_income_history.values
    profits = get_monthly_profit_history(expenses, incomes).values.unshift('profits')
    render json: { profit: profits, income: incomes.unshift('income'), expenses: expenses.unshift('expenses') }
  end

  def get_monthly_expense_history
    @expenses = current_user.expenses.where('extract(year from created_at) = ?', Time.now.year)
    data = {}
    months = Date::MONTHNAMES.dup
    months.shift
    months.each_with_index do |month, i|
      data.merge!(month => @expenses.where('extract(month from created_at) = ?', i + 1).sum(:amount))
    end
    data
  end

  def get_monthly_income_history
    @incomes = current_user.incomes.where('extract(year from created_at) = ?', Time.now.year)
    data = {}
    months = Date::MONTHNAMES.dup
    months.shift
    months.each_with_index do |month, i|
      data.merge!(month => @incomes.where('extract(month from created_at) = ?', i + 1).sum(:amount))
    end
    data
  end

  def get_monthly_profit_history(expenses, incomes)
    data = {}
    months = Date::MONTHNAMES.dup
    months.shift
    months.each_with_index do |month, i|
      data.merge!(month => expenses[i] - incomes[i])
    end
    data
  end
end
