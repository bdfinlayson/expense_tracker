class RecurringExpense < ApplicationRecord
  enum frequency: [:weekly, :biweekly, :monthly, :annually]
  belongs_to :expense_category
  belongs_to :vendor
  belongs_to :user
  accepts_nested_attributes_for :expense_category, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :vendor, reject_if: :all_blank, allow_destroy: true
  validates_presence_of :user_id, :amount, :vendor_id, :expense_category_id
  validates_inclusion_of :recurring, :in => [true], if: 'frequency.present?'
  validates :frequency, presence: true, if: 'recurring.present?'
end
