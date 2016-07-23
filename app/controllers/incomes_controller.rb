require_dependency 'app/models/forms/income_form' unless Rails.env == 'production'

class IncomesController < ApplicationController
  def index
    @form = IncomeForm.new(Income.new)
    @incomes = current_user.incomes
    @vendors = current_user.vendors
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
    params[:income][:frequency] = params[:income][:frequency].to_i if params[:income][:frequency].present?
    params[:income][:recurring] = params[:income][:recurring].to_i if params[:income][:recurring].present?

    if @income.update(
        amount: params[:income][:amount],
        created_at: params[:income][:created_at],
        vendor_id: params[:income][:vendor_id],
        frequency: params[:income][:frequency],
        recurring: params[:income][:recurring]
    )
      return redirect_to incomes_path, notice: 'Income updated!'
    else
      return redirect_to incomes_path, alert: @income.errors.full_messages.join('!, ').concat('!')
    end
  end

  def create
    @form = IncomeForm.new(Income.new)
    vendor = create_new_vendor if new_vendor?
    params[:income][:vendor_id] = vendor.id if vendor.present?
    if @form.validate(income_params)
      @form.save
      return redirect_to incomes_path, notice: 'Income saved!'
    else
      return redirect_to incomes_path, alert: @form.errors.full_messages.join('. ').concat('.')
    end
  end

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


  def income_params
    params[:income][:frequency] = params[:income][:frequency].to_i if params[:income][:frequency].present?
    params[:income][:recurring] = params[:income][:recurring].to_i if params[:income][:recurring].present?
    params.require(:income).permit(:amount, :created_at, :vendor, :vendor_id, :recurring, :frequency).merge!(user_id: current_user.id)
  end
end
