require_dependency 'app/models/forms/expense_form'

class ExpensesController < ApplicationController

  def new
    set_new_form
  end

  def create
    if validate!
      @form.save
      set_new_form
      return render :new, notice: 'Expense saved!'
    else
      return render :new, alert: 'Unable to save expense!'
    end
  end

  def validate!
    set_new_form
    @form.validate(expense_params)
  end

  def set_new_form
    @form = ExpenseForm.new(Expense.new)
  end

  def expense_params
    params.require(:expense).permit(:amount)
  end

end
