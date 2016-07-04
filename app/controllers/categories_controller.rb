require_dependency 'app/models/forms/category_form'

class CategoriesController < ApplicationController
  def edit
    @category = Category.find(params[:id])
    @parent_id = @category.parent.id if @category.parent.present?
    @form = CategoryForm.new(@category)
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      if category_params[:ancestry].nil?
        @category.update_attribute(:ancestry, '')
      end
      return redirect_to categories_path, notice: 'Category updated!'
    else
      return redirect_to edit_category_path(@category), alert: @category.errors.full_messages.join('! ').concat('!')
    end
  end

  def index
    @categories = Category.where(user_id: current_user.id)
  end

  def category_params
    params.require(:category).permit(:name, :ancestry).merge(user_id: current_user.id)
  end
end
