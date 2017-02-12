class PendingExpense < ApplicationRecord
  include BaseModel
  belongs_to :user
  belongs_to :recurring_expense
  belongs_to :expense_category
  belongs_to :vendor
  belongs_to :account_payable

  default_scope { where.not(cleared: true) }

  validates_presence_of :amount, :vendor_id, :user_id, :recurring_expense_id, :expense_category_id
end
