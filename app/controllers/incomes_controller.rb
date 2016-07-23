require_dependency 'app/models/forms/income_form' unless Rails.env == 'production'

class IncomesController < ApplicationController
  def index
    @form = IncomeForm.new(Income.new)
    @incomes = current_user.incomes
  end
end
