class RecurringExpense < ApplicationRecord
  include BaseModel
  enum frequency: [:weekly, :biweekly, :monthly, :annually]
  belongs_to :expense_category
  belongs_to :vendor
  belongs_to :user
  has_many :expenses
  has_many :pending_expenses
  accepts_nested_attributes_for :expense_category, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :vendor, reject_if: :all_blank, allow_destroy: true
  validates_presence_of :user_id, :amount, :vendor_id, :expense_category_id, :frequency
  validates :vendor_id, uniqueness: {scope: :user_id}

  after_save :add_due_day { update_column(:due_day, created_at.day) }
end
