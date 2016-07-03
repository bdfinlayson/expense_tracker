require_dependency 'app/models/forms/expense_form'

class ExpensesController < ApplicationController

  def new
    set_new_form
  end

  def create
    if validate!
      @form.save
      set_new_form
      return redirect_to root_path, notice: 'Expense saved!'
    else
      return redirect_to root_path, alert: @form.errors.full_messages
    end
  end

  def validate!
    set_new_form
    @form.validate(expense_params.merge(user_id: current_user.id))
  end

  def set_new_form
    @form = ExpenseForm.new(Expense.new)
  end

  def expense_params
    params.require(:expense).permit(:amount, :category_id, :vendor_id)
  end

end
