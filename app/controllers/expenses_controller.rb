require_dependency 'app/models/forms/expense_form' unless Rails.env == 'production'

class ExpensesController < ApplicationController
  before_action :set_new_form, only: [:new, :create, :update]

  def new
  end

  def index
    @search_query = search_query
    @q = Expense.where(user: current_user).order(created_at: :desc).ransack( search_query )
    @expenses = @q.result
    @total_expenses = @expenses.map(&:amount).sum
    @total_items = @expenses.count
  end

  def search_query
    return {} unless params[:q].present?
    return {} unless params[:q]['category_name_or_vendor_name_cont'].present?
    { category_name_or_vendor_name_cont: params[:q]['category_name_or_vendor_name_cont'] }
  end

  def create
    if validate!
      @form.save
      return redirect_to root_path, notice: 'Expense saved!'
    else
      return redirect_to root_path, alert: @form.errors.full_messages.join("! ").concat('!')
    end
  end

  def update
    @expense = Expense.find params[:expense][:id]
    @search_query = params[:expense][:q]
    if @expense.update(
        amount: params[:expense][:amount],
        created_at: params[:expense][:created_at],
        vendor_id: params[:expense][:vendor_id],
        category_id: params[:expense][:category_id]
    )
      return redirect_to build_expenses_path, notice: 'Expense updated!'
    else
      return redirect_to build_expenses_path, alert: @expense.errors.full_messages.join('!, ').concat('!')
    end
  end

  def build_expenses_path
    expenses_path(
      q: {
        category_name_or_vendor_name_cont: ( params[:expense][:q].present? ? params[:expense][:q][:category_name_or_vendor_name_cont] : [] )
      }
    )
  end

  def create_new_category
    Category.create(
      name: expense_params[:category][:name],
      user_id: current_user.id
    )
  end

  def destroy
    @expense = Expense.find params[:id]
    @expense.destroy
    redirect_to build_expenses_path, notice: 'Expense destroyed!'
  end

  def new_category?
    return false if not expense_params[:category].present?
    expense_params[:category][:name].present?
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
    if category && vendor
      @form.validate(expense_params.merge(user_id: current_user.id, category_id: category.id, vendor_id: vendor.id))
    elsif category
      @form.validate(expense_params.merge(user_id: current_user.id, category_id: category.id))
    elsif vendor
      @form.validate(expense_params.merge(user_id: current_user.id, vendor_id: vendor.id))
    else
      @form.validate(expense_params.merge(user_id: current_user.id))
    end
  end

  def set_new_form
    @form = ExpenseForm.new(Expense.new)
  end

  def expense_params
    params.require(:expense).permit(
      :amount,
      :created_at,
      :category_id,
      :vendor_id,
      category: [
        :id,
        :name,
        :done,
        :_destroy
      ],
      vendor: [
        :id,
        :name,
        :note,
        :done,
        :_destroy
      ]
    )
  end
end
