require_dependency 'app/models/forms/recurring_income_form' unless Rails.env == 'production'

class RecurringIncomesController < ApplicationController
  def index
    @form = RecurringIncomeForm.new(RecurringIncome.new)
    @incomes = current_user.recurring_incomes.order(created_at: :desc)
    @total_items = @incomes.count
    @vendors = current_user.vendors.order('lower(name) asc')
    @categories = current_user.income_categories.order('lower(name) asc')
  end

  def destroy
    @income = RecurringIncome.find(params[:id])
    if @income.destroy
      return redirect_to recurring_incomes_path, notice: 'Recurring Income deleted!'
    else
      return redirect_to recurring_incomes_path, alert: 'Unable to delete recurring income'
    end
  end

  def update
    @income = RecurringIncome.find params[:recurring_income][:id]
    p = recurring_income_params
    p[:frequency] = p[:frequency].to_i
    @income.update_attributes(p)
    raise if @income.errors.any?
    return redirect_to recurring_incomes_path, notice: 'Recurring Income updated!'
  rescue
    return redirect_to recurring_incomes_path, alert: @income.errors.full_messages.join('!, ').concat('!')
  end

  def create
    if validate!
      @form.save
      Recurrence.new(@form.model).compute
      return redirect_to recurring_incomes_path, notice: 'Income saved!'
    else
      return redirect_to recurring_incomes_path, alert: @form.errors.full_messages.join('. ').concat('.')
    end
  end
  def recurring_income_params
    params.require(:recurring_income).permit(
      :amount,
      :created_at,
      :income_category_id,
      :vendor_id,
      :note,
      :frequency,
      income_category: [
        :id,
        :name,
        :_destroy
      ],
      vendor: [
        :id,
        :name,
        :note,
        :_destroy
      ]
    ).merge!(user_id: current_user.id)
  end
  private

  def create_new_vendor
    Vendor.create(
      name: params[:recurring_income][:vendor][:name],
      note: params[:recurring_income][:vendor][:note],
      user_id: current_user.id
    )
  end


  def new_vendor?
    return false if not params[:recurring_income][:vendor].present?
    params[:recurring_income][:vendor][:name].present?
  end


  def create_new_category
    IncomeCategory.create(
      name: recurring_income_params[:income_category][:name],
      user_id: current_user.id
    )
  end

  def new_category?
    return false if not recurring_income_params[:income_category].present?
    recurring_income_params[:income_category][:name].present?
  end


  def validate!
    @form = RecurringIncomeForm.new(RecurringIncome.new)
    category = create_new_category if new_category?
    vendor = create_new_vendor if new_vendor?
    if category && vendor
      @form.validate(recurring_income_params.merge(user_id: current_user.id, income_category_id: category.id, vendor_id: vendor.id))
    elsif category
      @form.validate(recurring_income_params.merge(user_id: current_user.id, income_category_id: category.id))
    elsif vendor
      @form.validate(recurring_income_params.merge(user_id: current_user.id, vendor_id: vendor.id))
    else
      @form.validate(recurring_income_params.merge(user_id: current_user.id))
    end
  end
end
