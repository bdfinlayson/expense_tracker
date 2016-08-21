require_dependency 'app/models/forms/income_form' unless Rails.env == 'production'

class IncomesController < ApplicationController
  def index
    @form = IncomeForm.new(Income.new)
    @incomes = current_user.incomes.order(created_at: :desc)
    @vendors = current_user.vendors.order('lower(name) asc')
    @categories = current_user.income_categories.order('lower(name) asc')
  end

  def destroy
    @income = Income.find(params[:id])
    if @income.destroy
      return redirect_to incomes_path, notice: 'Income deleted!'
    else
      return redirect_to incomes_path, alert: 'Unable to delete income'
    end
  end


  def update
    @income = Income.find params[:id]
    if validate!
      @income.update_attributes(income_params)
      return redirect_to incomes_path, notice: 'Income updated!'
    else
      return redirect_to incomes_path, alert: @form.errors.full_messages.join('!, ').concat('!')
    end
  end

  def create
    if validate!
      @form.save
      return redirect_to incomes_path, notice: 'Income saved!'
    else
      return redirect_to incomes_path, alert: @form.errors.full_messages.join('. ').concat('.')
    end
  end
  def income_params
    params.require(:income).permit(
      :amount,
      :created_at,
      :income_category_id,
      :vendor_id,
      :note,
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
      name: params[:income][:vendor][:name],
      note: params[:income][:vendor][:note],
      user_id: current_user.id
    )
  end


  def new_vendor?
    return false if not params[:income][:vendor].present?
    params[:income][:vendor][:name].present?
  end


  def create_new_category
    IncomeCategory.create(
      name: income_params[:income_category][:name],
      user_id: current_user.id
    )
  end

  def new_category?
    return false if not income_params[:income_category].present?
    income_params[:income_category][:name].present?
  end


  def validate!
    @form = IncomeForm.new(Income.new)
    category = create_new_category if new_category?
    vendor = create_new_vendor if new_vendor?
    if category && vendor
      @form.validate(income_params.merge(user_id: current_user.id, income_category_id: category.id, vendor_id: vendor.id))
    elsif category
      @form.validate(income_params.merge(user_id: current_user.id, income_category_id: category.id))
    elsif vendor
      @form.validate(income_params.merge(user_id: current_user.id, vendor_id: vendor.id))
    else
      @form.validate(income_params.merge(user_id: current_user.id))
    end
  end



end
