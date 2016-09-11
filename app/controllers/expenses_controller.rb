require_dependency 'app/models/forms/expense_form' unless Rails.env == 'production'

class ExpensesController < ApplicationController
  before_action :set_new_form, only: [:index, :create, :update]
  include Querier
  include Calculator
  include Calendar

  def index
    @months = months params
    @expenses = all_records_for('expenses', Time.now.year, @months[:current][:number])
    @total_items = @expenses.count
    @vendors = current_user.vendors.order('lower(name) asc')
    @categories = current_user.expense_categories.order('lower(name) asc')
    @total_expenses_this_month = get_sum_of @expenses
    @total_expenses_last_month = get_sum_of(all_records_for('expenses', Time.now.year, @months[:last][:number]))
    @columns = %w(date item_amount vendor_name category_name recurring?)
    @form_partial = 'form/show'
    @new_category = ExpenseCategory.new
    @new_vendor = Vendor.new
    @total_income_this_month = get_sum_of(all_records_for('incomes', Time.now.year, @months[:current][:number]))
    @stats = {
      'This Month': "$#{@total_expenses_this_month}",
      'Last Month': "$#{@total_expenses_last_month}",
      '% of Income Spent': "#{percentage_of @total_expenses_this_month, @total_income_this_month}%"
    }
  end

  def search_query
    return {} unless params[:q].present?
    return {} unless params[:q]['expense_category_name_or_vendor_name_cont'].present?
    { expense_category_name_or_vendor_name_cont: params[:q]['expense_category_name_or_vendor_name_cont'] }
  end

  def create
    if validate!
      @form.save
      return redirect_to :back, notice: 'Expense saved!'
    else
       redirect_to :back, alert: @form.errors.full_messages.join("! ").concat('!')
    end
  end

  def update
    @expense = Expense.find params[:id]
    if validate!
      @expense.update(expense_params)
      return redirect_to :back, notice: 'Expense updated!'
    else
      return redirect_to :back, alert: @form.errors.full_messages.join('!, ').concat('!')
    end
  end

  def create_new_category
    ExpenseCategory.create(
      name: expense_params[:expense_category][:name],
      user_id: current_user.id
    )
  end

  def destroy
    @expense = Expense.find params[:id]
    @expense.destroy
    redirect_to :back, notice: 'Expense destroyed!'
  end

  def new_category?
    return false if not expense_params[:expense_category].present?
    expense_params[:expense_category][:name].present?
  end

  def create_new_vendor
    Vendor.create(
      name: expense_params[:vendor][:name],
      note: expense_params[:vendor][:note],
      user_id: current_user.id
    )
  end

  def new_vendor?
    return false if not expense_params[:vendor].present?
    expense_params[:vendor][:name].present?
  end

  def validate!
    category = create_new_category if new_category?
    vendor = create_new_vendor if new_vendor?
    params[:expense].delete :expense_category
    params[:expense].delete :vendor
    if category && vendor
      params[:expense][:expense_category_id] = category.id
      params[:expense][:vendor_id] = vendor.id
    elsif category
      params[:expense][:expense_category_id] = category.id
    elsif vendor
      params[:expense][:vendor_id] = vendor.id
    else
      ''
    end
    @form.validate(expense_params.merge(user_id: current_user.id))
  end

  def set_new_form
    @form = ExpenseForm.new(Expense.new)
  end

  def expense_params
    params.require(:expense).permit(
      :amount,
      :created_at,
      :expense_category_id,
      :vendor_id,
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
