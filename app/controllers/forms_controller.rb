class FormsController < ApplicationController
  before_action :fetch_resource

  def create
    @frequencies = RecurringExpense.frequencies
    @vendors = current_user.vendors
    @controller = params[:form_controller]
    if [params[:model_name]].select { |name| name.match /expense|budget/i }.present?
      @new_category = ExpenseCategory.new
      @categories = current_user.expense_categories
    else
      @new_category = IncomeCategory.new
      @categories = current_user.income_categories
    end
    @new_vendor = Vendor.new
    render partial: 'form/show', locals: { model: @resource, title: "Edit #{@resource.class.name.titleize}" }, layout: false
  end

  private
    def fetch_resource
      @resource = params[:model_name].constantize.find(params[:model_id])
    end
end
