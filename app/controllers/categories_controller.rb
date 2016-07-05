require_dependency 'app/models/forms/category_form' unless Rails.env == 'production'

class CategoriesController < ApplicationController
  def edit
    @category = Category.find(params[:id])
    @form = CategoryForm.new(@category)
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      return redirect_to expenses_path, notice: 'Category updated!'
    else
      return redirect_to edit_category_path(@category), alert: @category.errors.full_messages.join('! ').concat('!')
    end
  end

  def create
    @form = CategoryForm.new(Category.new)
    if @form.validate(category_params)
      @form.save
      return redirect_to categories_path, notice: 'Category created!'
    else
      return redirect_to categories_path, alert: @form.errors.full_messages.join('! ').concat('!')
    end
  end

  def destroy
    @category = Category.find params[:id]
    if @category.expenses.any?
      return redirect_to categories_path(@category), alert: 'Cannot delete category. Please reassociate any expenses.'
    else
      @category.destroy
      return redirect_to categories_path, notice: 'Category deleted!'
    end
  end

  def index
    @form = CategoryForm.new(Category.new)
    @categories = Category.where(user_id: current_user.id)
  end

  def category_params
    params.require(:category).permit(:name).merge(user_id: current_user.id)
  end
end
