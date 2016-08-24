require_dependency 'app/models/forms/income_category_form' unless Rails.env == 'production'

class IncomeCategoriesController < ApplicationController
  def edit
    @category = IncomeCategory.find(params[:id])
    @form = IncomeCategoryForm.new(@category)
  end

  def update
    @category = IncomeCategory.find(params[:id])
    if @category.update(category_params)
      return redirect_to income_categories_path, notice: 'Income Category updated!'
    else
      return redirect_to edit_income_category_path(@category), alert: @category.errors.full_messages.join('! ').concat('!')
    end
  end

  def create
    @form = IncomeCategoryForm.new(IncomeCategory.new)
    if @form.validate(category_params)
      @form.save
      return redirect_to income_categories_path, notice: 'Category created!'
    else
      return redirect_to income_categories_path, alert: @form.errors.full_messages.join('! ').concat('!')
    end
  end

  def destroy
    @category = IncomeCategory.find params[:id]
    if @category.incomes.any? || @category.recurring_incomes.any?
      return redirect_to income_categories_path, alert: 'Cannot delete income category. Please reassociate any incomes.'
    else
      @category.destroy
      return redirect_to income_categories_path, notice: 'Income Category deleted!'
    end
  end

  def index
    @form = IncomeCategoryForm.new(IncomeCategory.new)
    @categories = IncomeCategory.where(user_id: current_user.id).order('lower(name) asc')
    @total_items = @categories.count
  end

  def category_params
    params.require(:income_category).permit(:name).merge(user_id: current_user.id)
  end
end
