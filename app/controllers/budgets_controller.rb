require_dependency 'app/models/forms/budget_form' unless Rails.env == 'production'

class BudgetsController < ApplicationController
  def index
    @budgets = current_user.budgets.order(amount: :desc)
    @total_items = @budgets.count
    @form = BudgetForm.new(Budget.new)
    @categories = current_user.expense_categories.order('lower(name) asc')
    @columns = %w(percent_spent category_name budgeted_amount spent left)
    @form_partial = 'form/show'
    @new_category = ExpenseCategory.new
    @income = current_user.recurring_incomes.pluck(:amount).sum
    @total_budget = @budgets.pluck(:amount).sum
    @stats = {
      'Total Budget': "$#{@total_budget}",
      'Budget vs Income':"#{((@total_budget / @income) * 100).round(2)}%"
    }
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

  def budget_params
    params.require(:budget).permit(:amount, :expense_category_id).merge!(user_id: current_user.id)
  end
end
