require_dependency 'app/models/forms/income_form' unless Rails.env == 'production'

class IncomesController < ApplicationController
  include Querier
  include Calendar
  include Calculator

  def index
    @months = months params
    @form = IncomeForm.new(Income.new)
    @incomes = all_records_for('incomes', Time.now.year, @months[:current][:number])
    @total_items = @incomes.count
    @vendors = current_user.vendors.order('lower(name) asc')
    @categories = current_user.income_categories.order('lower(name) asc')
    @new_vendor = Vendor.new
    @new_category = IncomeCategory.new
    @form_partial = 'form/show'
    @columns = %w(date item_amount vendor_name category_name recurring?)
    @total_income_this_month = get_sum_of @incomes
    @total_expenses_this_month = get_sum_of(all_records_for('expenses', Time.now.year, @months[:current][:number]))
    @stats = {
      'This Month': "$#{@total_income_this_month}",
      '% of Income Spent': "#{percentage_of @total_expenses_this_month, @total_income_this_month}%"
    }
  end

  def destroy
    @income = Income.find(params[:id])
    if @income.destroy
      return redirect_to :back, notice: 'Income deleted!'
    else
      return redirect_to :back, alert: 'Unable to delete income'
    end
  end


  def update
    @income = Income.find params[:id]
    if validate!
      @income.update_attributes(income_params)
      return redirect_to :back, notice: 'Income updated!'
    else
      return redirect_to :back, alert: @form.errors.full_messages.join('!, ').concat('!')
    end
  end

  def create
    if validate!
      @form.save
      return redirect_to :back, notice: 'Income saved!'
    else
      return redirect_to :back, alert: @form.errors.full_messages.join('. ').concat('.')
    end
  end

  private
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
      params[:income].delete :income_category
      params[:income].delete :vendor
      if category && vendor
        params[:income][:income_category_id] = category.id
        params[:income][:vendor_id] = vendor.id
      elsif category
        params[:income][:income_category_id] = category.id
      elsif vendor
        params[:income][:vendor_id] = vendor.id
      else
        ''
      end
      @form.validate(income_params.merge(user_id: current_user.id))
    end
end
