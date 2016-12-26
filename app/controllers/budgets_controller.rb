require_dependency 'app/models/forms/budget_form' unless Rails.env == 'production'

class BudgetsController < ApplicationController
  include Calendar

  def index
    @months = months(params)
    @budgets = current_user.budgets.order(amount: :desc).decorate(context: { month: @months[:current][:number] } )
    @total_items = @budgets.count
    @form = BudgetForm.new(Budget.new)
    @categories = current_user.expense_categories.order('lower(name) asc')
    @columns = %w(percent_spent category_name budgeted_amount spent left)
    @form_partial = 'form/show'
    @new_category = ExpenseCategory.new
    @income = current_user.recurring_incomes
    @total_budget = @budgets.pluck(:amount).sum
    @summed_income = get_monthly_income_sum(@income)
    @stats = {
      'Total Budget': "$#{@total_budget}",
      'Budget vs Income':"#{((@total_budget / @summed_income) * 100).round(2)}%"
    }
    @unbudgeted_categories = @categories.pluck(:name) - @budgets.map(&:category_name)
  end

  def create
    @form = BudgetForm.new(Budget.new)
    if @form.validate(budget_params)
      @form.save
      return redirect_to budgets_path, notice: 'Budget created!'
    else
      redirect_to budgets_path, alert: @form.errors.full_messages.join('. ').concat('.')
    end
  end

  def update
    @budget = Budget.find(params[:id])
    if @budget.update(budget_params)
      return redirect_to budgets_path, notice: 'Budget updated!'
    else
      redirect_to budgets_path, alert: @budget.errors.full_messages.join('. ').concat('.')
    end
  end


  def destroy
    @budget = Budget.find(params[:id])
    if @budget.destroy
      return redirect_to budgets_path, notice: 'Budget destroyed!'
    else
      redirect_to budgets_path, alert: 'Unable to destroy budget'
    end
  end

  def edit
    @budget = Budget.find(params[:id])
    @form = BudgetForm.new(@budget)
    @categories = current_user.expense_categories
  end

  private
    def get_monthly_income_sum(incomes)
      income = []
      incomes.each do |i|
        case i.frequency
        when 'monthly'
          income.push i.amount
        when 'biweekly'
          income.push (i.amount * 2)
        when 'weekly'
          income.push (i.amount * 4)
        when 'annually'
          income.push (i.amount / 12)
        else
          ''
        end
      end
      income.sum
    end

    def budget_params
      params.require(:budget).permit(:amount, :expense_category_id).merge!(user_id: current_user.id)
    end
end
