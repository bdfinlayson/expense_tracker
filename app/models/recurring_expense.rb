class RecurringExpense < ApplicationRecord
  enum frequency: [:weekly, :biweekly, :monthly, :annually]
end
