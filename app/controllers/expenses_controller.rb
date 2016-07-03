require_dependency 'app/models/forms/expense_form'

class ExpensesController < ApplicationController
  before_action :set_new_form, only: [:new, :create]

  def new
  end

  def index
    @q = Expense.where(user: current_user).ransack( search_query )
    @expenses = @q.result
  end

  def search_query
    return {} unless params[:q].present?
    if params[:q]['category_name_or_vendor_name_cont'].present?
      { category_name_or_vendor_name_cont: params[:q]['category_name_or_vendor_name_cont'] }
    end
  end

  def create
    if validate!
      @form.save
      return redirect_to root_path, notice: 'Expense saved!'
    else
      # flash[:alert] = @form.errors.full_messages
      # return render :new, form: @form
      return redirect_to root_path, alert: @form.errors.full_messages.join('!, ').concat('!')
    end
  end

  def create_new_category
    if expense_params[:category][:ancestry].present?
      Category.create(
        name: expense_params[:category][:name],
        parent: Category.find(expense_params[:category][:ancestry]),
        user_id: current_user.id
      )
    else
      Category.create(
        name: expense_params[:category][:name],
        user_id: current_user.id
      )
    end
  end

  def new_category?
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
      :category_id,
      :vendor_id,
      category: [
        :id,
        :name,
        :ancestry,
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
