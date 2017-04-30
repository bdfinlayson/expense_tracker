class CategoriesController < ApplicationController
  def create
    category = Category.create(category_params)
    if category.persisted?
      render json: category, serializer: CategoriesSerializer
    else
      render json: category.errors.to_json
    end

  end

  def category_params
    params.require(:category).permit(:name, :category_type).merge(user_id: current_user.id)
  end
end
