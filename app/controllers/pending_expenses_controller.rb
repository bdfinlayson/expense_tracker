class PendingExpensesController < ApplicationController
  def index
    @columns = %w(date item_amount vendor_name category_name)
    @form_partial = 'form/show'
    @new_category = ExpenseCategory.new
    @new_vendor = Vendor.new
    @categories = current_user.expense_categories.order('lower(name) asc')
    @vendors = current_user.vendors.order('lower(name) asc')
    @pending_expenses = current_user.pending_expenses
    @total_items = @pending_expenses.count
  end

  def destroy
    @pending = PendingExpense.find params[:id]
    @pending.destroy
    redirect_to pending_expenses_path, notice: 'Pending Expense destroyed!'
  end

  def clear
    @pending_expense = PendingExpense.find params[:id]
    attrs = @pending_expense.attributes.except('frequency', 'created_at', 'updated_at', 'note', 'id', 'cleared', 'due_day')
    Expense.create(attrs)
    @pending_expense.update(cleared: true)
    redirect_to pending_expenses_path, notice: 'Expense logged!'
  end

  def update
    @pending_expense = PendingExpense.find params[:id]
    @pending_expense.update(amount: params[:pending_expense][:amount])
    if @pending_expense.errors.empty?
      redirect_to pending_expenses_path, notice: 'Pending expense updated!'
    else
      redirect_to pending_expenses_path, notice: 'There was an error updating your pending expense. Please try again.'
    end
  end
end
