class OverviewsController < ApplicationController
  respond_to :json, :html

  def index
    @year = params[:year] ? params[:year].to_i : Time.now.year
    @last_year = @year.to_i - 1
    @next_year = @year.to_i + 1
    @total_expenses_this_month = current_user.expenses.where('extract(year from created_at) = ?', @year).where('extract(month from created_at) = ?', Time.now.month).pluck(:amount).sum
    @monthly_expenses_chart = get_monthly_expense_history
    @monthly_income_history = get_monthly_income_history
    @monthly_profit_history = get_monthly_profit_history(@monthly_expenses_chart.values, @monthly_income_history.values)
    @income_this_month = current_user.incomes.where('extract(year from created_at) = ?', @year).where('extract(month from created_at) = ?', Time.now.month).pluck(:amount).sum
    @categories = current_user.expense_categories.order('lower(name) asc')
    @total_for_month = current_user.budgets.pluck(:amount).sum
    @total_spent = current_user.expense_categories.map(&:summed_expenses).sum
    @net_worth_for_month = @income_this_month - @total_expenses_this_month
    expenses = get_monthly_expense_history.values
    incomes = get_monthly_income_history.values
    expense_history = current_user.expenses.pluck(:amount).sum
    income_history = current_user.incomes.pluck(:amount).sum
    @profit_history = income_history - expense_history
    @profits = get_monthly_profit_history(expenses, incomes).values
    profitability = get_monthly_percent_profit(@profits, incomes).delete_if {|x| x == 0}
    @average_profitability = (profitability.reduce(:+).to_f / profitability.size).round(2)
    @stats = {
      "#{@year} Avg Profitability": "#{@average_profitability}%",
      'Total Avg Profitability': "#{((@profit_history / expense_history) * 100).round(2)}%",
      "#{@year} Net Worth": "$#{year_net_worth.round(2)}",
      'Total Net Worth': "$#{(current_user.beginning_cash_on_hand + @profit_history).round(2)}"
    }
  end

  def year_net_worth
    if @year == Time.now.year
      current_user.beginning_cash_on_hand + @profit_history
    else
      current_user.beginning_cash_on_hand + @profits.sum
    end
  end

  def data
    @year = params[:year] || Time.now.year
    expenses = get_monthly_expense_history.values
    incomes = get_monthly_income_history.values
    profits = get_monthly_profit_history(expenses, incomes).values
    profitability = get_monthly_percent_profit(profits, incomes)
    net_worth = get_net_worth(profits)
    months = %w(Jul Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec)
    render json: { net_worth: net_worth, profitability: profitability, months: months, profit: profits.unshift('profits'), income: incomes.unshift('income'), expenses: expenses.unshift('expenses') }
  end

  def get_net_worth(profits)
    starting_cash = current_user.beginning_cash_on_hand
    worth = []
    profits.each do |p|
      if p.zero?
        worth.push "N/A"
      else
        worth.push(starting_cash += p)
      end
    end
    worth
  end

  def get_monthly_percent_profit(profits, incomes)
    p = []
    profits.each_with_index do |profit, i|
      if profit.zero? && incomes[i].zero?
        p.push 0
      else
        p.push(((Float(profit) / Float(incomes[i])) * 100).round(2))
      end
    end
    p
  end

  def get_monthly_expense_history
    @expenses = current_user.expenses.where('extract(year from created_at) = ?', @year)
    data = {}
    months = Date::MONTHNAMES.dup
    months.shift
    months.each_with_index do |month, i|
      data.merge!(month => @expenses.where('extract(month from created_at) = ?', i + 1).sum(:amount).round(0))
    end
    data
  end

  def get_monthly_income_history
    @incomes = current_user.incomes.where('extract(year from created_at) = ?', @year)
    data = {}
    months = Date::MONTHNAMES.dup
    months.shift
    months.each_with_index do |month, i|
      data.merge!(month => @incomes.where('extract(month from created_at) = ?', i + 1).sum(:amount).round(0))
    end
    data
  end

  def get_monthly_profit_history(expenses, incomes)
    data = {}
    months = Date::MONTHNAMES.dup
    months.shift
    months.each_with_index do |month, i|
      data.merge!(month => (incomes[i] - expenses[i]).round(0))
    end
    data
  end
end
