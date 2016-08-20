require_dependency 'app/models/forms/expense_category_form' unless Rails.env == 'production'

class ExpenseCategoriesController < ApplicationController
  def edit
    @category = ExpenseCategory.find(params[:id])
    @form = ExpenseCategoryForm.new(@category)
  end

  def update
    @category = ExpenseCategory.find(params[:id])
    if @category.update(category_params)
      return redirect_to expense_categories_path, notice: 'Category updated!'
    else
      return redirect_to edit_category_path(@category), alert: @category.errors.full_messages.join('! ').concat('!')
    end
  end

  def create
    @form = ExpenseCategoryForm.new(ExpenseCategory.new)
    if @form.validate(category_params)
      @form.save
      return redirect_to categories_path, notice: 'Category created!'
    else
      return redirect_to categories_path, alert: @form.errors.full_messages.join('! ').concat('!')
    end
  end

  def destroy
    @category = ExpenseCategory.find params[:id]
    if @category.expenses.any?
      return redirect_to categories_path(@category), alert: 'Cannot delete category. Please reassociate any expenses.'
    else
      @category.destroy
      return redirect_to categories_path, notice: 'Category deleted!'
    end
  end

  def index
    @form = ExpenseCategoryForm.new(ExpenseCategory.new)
    @categories = ExpenseCategory.where(user_id: current_user.id).order(name: :asc)
  end

  def category_params
    params.require(:expense_category).permit(:name).merge(user_id: current_user.id)
  end
end
