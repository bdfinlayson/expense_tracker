class Expense < ApplicationRecord
  include BaseModel
  belongs_to :expense_category
  belongs_to :recurring_expense
  belongs_to :vendor
  belongs_to :user
  accepts_nested_attributes_for :expense_category, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :vendor, reject_if: :all_blank, allow_destroy: true
  validates_presence_of :user_id, :amount, :vendor_id, :expense_category_id
end
