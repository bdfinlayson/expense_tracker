require_dependency 'app/models/forms/recurring_expense_form' unless Rails.env == 'production'

class RecurringExpensesController < ApplicationController
  before_action :set_new_form, only: [:index, :create, :update]

  def index
    @expenses = current_user.recurring_expenses.order(created_at: :desc)
    @total_expenses = @expenses.map(&:amount).sum
    @total_items = @expenses.count
    @vendors = current_user.vendors.order('lower(name) asc')
    @categories = current_user.expense_categories.order('lower(name) asc')
    @frequencies = RecurringExpense.frequencies
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
    @expense = RecurringExpense.find params[:recurring_expense][:id]
    p = recurring_expense_params
    p[:frequency] = p[:frequency].to_i
    @expense.update_attributes(p)
    raise if @expense.errors.any?
    return redirect_to recurring_expenses_path, notice: 'Recurring Expense updated!'
  rescue
    return redirect_to recurring_expenses_path, alert: @expense.errors.full_messages.join('!, ').concat('!')
  end

  def create_new_category
    ExpenseCategory.create(
      name: recurring_expense_params[:expense_category][:name],
      user_id: current_user.id
    )
  end

  def destroy
    @expense = RecurringExpense.find params[:id]
    @expense.destroy
    redirect_to recurring_expenses_path, notice: 'Recurring Expense destroyed!'
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
    if category && vendor
      @form.validate(recurring_expense_params.merge(user_id: current_user.id, expense_category_id: category.id, vendor_id: vendor.id))
    elsif category
      @form.validate(recurring_expense_params.merge(user_id: current_user.id, expense_category_id: category.id))
    elsif vendor
      @form.validate(recurring_expense_params.merge(user_id: current_user.id, vendor_id: vendor.id))
    else
      @form.validate(recurring_expense_params.merge(user_id: current_user.id))
    end
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
