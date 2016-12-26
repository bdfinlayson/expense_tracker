class RecurringIncome < ApplicationRecord
  include BaseModel
  enum frequency: [:weekly, :biweekly, :monthly, :annually]
  belongs_to :user
  belongs_to :vendor
  belongs_to :income_category
  has_many :incomes
  validates_presence_of :income_category_id, :vendor_id, :user_id, :amount, :frequency
  accepts_nested_attributes_for :income_category, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :vendor, reject_if: :all_blank, allow_destroy: true

  after_save { update_column(:due_day, created_at.day) }
end
