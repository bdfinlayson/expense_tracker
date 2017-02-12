class Expense < ApplicationRecord
  include BaseModel
  belongs_to :expense_category
  belongs_to :recurring_expense
  belongs_to :vendor
  belongs_to :user
  belongs_to :account_payable
  accepts_nested_attributes_for :expense_category, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :vendor, reject_if: :all_blank, allow_destroy: true
  validates_presence_of :user_id, :amount, :vendor_id, :expense_category_id

  after_create do |expense|
    if expense.account_payable?
      ap = expense.account_payable
      ap.log_transaction(expense)
    end
  end

  def account_payable?
    self.account_payable.present?
  end
end
