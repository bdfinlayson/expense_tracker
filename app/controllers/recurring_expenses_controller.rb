require_dependency 'app/models/forms/recurring_expense_form' unless Rails.env == 'production'

class RecurringExpensesController < ApplicationController
  before_action :set_new_form, only: [:index, :create, :update]

  def index
    @expenses = current_user.recurring_expenses.order(due_day: :desc)
    @total_expenses = @expenses.map(&:amount).sum
    @total_items = @expenses.count
    @vendors = current_user.vendors.order('lower(name) asc')
    @categories = current_user.expense_categories.order('lower(name) asc')
    @frequencies = RecurringExpense.frequencies
    @columns = %w(due_day item_amount vendor_name category_name frequency)
    @form_partial = 'form/show'
    @new_category = ExpenseCategory.new
    @new_vendor = Vendor.new
    @budget = current_user.budgets.pluck(:amount).sum
    @stats = {
      'Total Recurring': "$#{@total_expenses.round(2)}",
      '% of Budget': "#{((@total_expenses / @budget) * 100).round(2)}%"
    }
  end

  def create
    if validate!
      @form.save
      Recurrence.new(@form.model).compute
      return redirect_to recurring_expenses_path, notice: 'Recurring Expense saved!'
    else
      return redirect_to recurring_expenses_path, alert: @form.errors.full_messages.join("! ").concat('!')
    end
  end

  def update
    @expense = RecurringExpense.find params[:id]
    if validate!
      @expense.update(recurring_expense_params)
      return redirect_to recurring_expenses_path, notice: 'Recurring Expense updated!'
    else
      return redirect_to recurring_expenses_path, alert: @expense.errors.full_messages.join('!, ').concat('!')
    end
  end

  def destroy
    @expense = RecurringExpense.find params[:id]
    @expense.destroy
    redirect_to recurring_expenses_path, notice: 'Recurring Expense destroyed!'
  end

  private
    def create_new_category
      ExpenseCategory.create(
        name: recurring_expense_params[:expense_category][:name],
        user_id: current_user.id
      )
    end

    def new_category?
      return false if not recurring_expense_params[:expense_category].present?
      recurring_expense_params[:expense_category][:name].present?
    end

    def create_new_vendor
      Vendor.create(
        name: recurring_expense_params[:vendor][:name],
        note: recurring_expense_params[:vendor][:note],
        user_id: current_user.id
      )
    end

    def new_vendor?
      return false if not recurring_expense_params[:vendor].present?
      recurring_expense_params[:vendor][:name].present?
    end

    def validate!
      category = create_new_category if new_category?
      vendor = create_new_vendor if new_vendor?
      params[:recurring_expense].delete :expense_category
      params[:recurring_expense].delete :vendor
      params[:recurring_expense][:frequency] = params[:recurring_expense][:frequency].to_i
      if category && vendor
        params[:recurring_expense][:expense_category_id] = category.id
        params[:recurring_expense][:vendor_id] = vendor.id
      elsif category
        params[:recurring_expense][:expense_category_id] = category.id
      elsif vendor
        params[:recurring_expense][:vendor_id] = vendor.id
      else
        ''
      end
      @form.validate(recurring_expense_params.merge(user_id: current_user.id))
    end

    def set_new_form
      @form = RecurringExpenseForm.new(RecurringExpense.new)
    end

    def recurring_expense_params
      params.require(:recurring_expense).permit(
        :amount,
        :created_at,
        :expense_category_id,
        :vendor_id,
        :frequency,
        :note,
        expense_category: [
          :id,
          :name,
          :_destroy
        ],
        vendor: [
          :id,
          :name,
          :note,
          :_destroy
        ]
      )
    end
end
