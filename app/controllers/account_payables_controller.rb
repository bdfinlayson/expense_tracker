require_dependency 'app/models/forms/account_payable_form' unless Rails.env == 'production'

class AccountPayablesController < ApplicationController
  before_action :set_new_form, only: [:index, :create, :update]

  def index
    @accounts_payables = current_user.account_payables.active
    @total_items = @accounts_payables.count
    @columns = %w(date name vendor_name starting_amount current_amount interest_free_expiration_at)
    @form_partial = 'form/show'
    @vendors = current_user.vendors
    @new_vendor = Vendor.new(user: current_user)
    @stats = {}
  end

  def create
    if validate!
      @form.save
      return redirect_to :back, notice: 'Account Payable created!'
    else
       redirect_to :back, alert: @form.errors.full_messages.join("! ").concat('!')
    end
  end

  def update
    @account_payable = AccountPayable.find params[:id]
    if validate!
      @account_payable.update(account_payable_params)
      return redirect_to :back, notice: 'Account Payable updated!'
    else
      return redirect_to :back, alert: @form.errors.full_messages.join('!, ').concat('!')
    end
  end

  def destroy
    @account_payable = AccountPayable.find params[:id]
    @account_payable.destroy
    redirect_to :back, notice: 'Account Payable destroyed!'
  end

  private
    def create_new_vendor
      Vendor.create(
        name: account_payable_params[:vendor][:name],
        note: account_payable_params[:vendor][:note],
        user_id: current_user.id
      )
    end

    def new_vendor?
      return false if not account_payable_params[:vendor].present?
      account_payable_params[:vendor][:name].present?
    end

    def validate!
      vendor = create_new_vendor if new_vendor?
      params[:account_payable].delete :vendor
      if vendor
        params[:account_payable][:vendor_id] = vendor.id
      else
        ''
      end
      @form.validate(account_payable_params.merge(user_id: current_user.id))
    end

    def set_new_form
      @form = AccountPayableForm.new(AccountPayable.new)
    end


    def account_payable_params
      params.require(:account_payable).permit(
        :name,
        :starting_amount,
        :current_amount,
        :created_at,
        :interest_free_expiration_at,
        :vendor_id,
        vendor: [
          :id,
          :name,
          :note,
          :_destroy
        ]
      )
    end
end
