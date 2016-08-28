require_dependency 'app/models/forms/vendor_form' unless Rails.env == 'production'

class VendorsController < ApplicationController
  def index
    @form = VendorForm.new(Vendor.new)
    @vendors = Vendor.where(user_id: current_user.id).order('name asc')
    @total_items = @vendors.count
    @form_partial = 'form/show'
    @columns = %w(name note)
  end

  def edit
    @form = VendorForm.new(Vendor.find(params[:id]))
  end

  def create
    @form = VendorForm.new(Vendor.new)
    if @form.validate(vendor_params)
      return redirect_to vendors_path, notice: 'Vendor created!'
    else
      return redirect_to vendors_path, alert: @form.errors.full_messages.join('! ').concat('!')
    end
  end

  def update
    @vendor = Vendor.find(params[:id])
    if @vendor.update(vendor_params)
      return redirect_to vendors_path, notice: 'Vendor updated!'
    else
      return redirect_to edit_vendor_path(@vendor), alert: @vendor.erros.full_messages.join('! ').concat('!')
    end
  end

  def destroy
    @vendor = Vendor.find(params[:id])
    if @vendor.expenses.any? || @vendor.incomes.any?
      return redirect_to vendors_path, alert: 'Cannot delete vendors with expenses/incomes.'
    else
      @vendor.destroy
      return redirect_to vendors_path, notice: 'Vendor deleted!'
    end
  end

  def vendor_params
    params.require(:vendor).permit(:name, :note).merge(user_id: current_user.id)
  end
end
