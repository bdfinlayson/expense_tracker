require 'reform/form/coercion'

class RecurringIncomeForm < Reform::Form
  feature Coercion
  property :amount
  property :user_id
  property :vendor_id, type: Types::Form::Int
  property :income_category_id, type: Types::Form::Int
  property :frequency, type: Types::Form::Int
  property :created_at
  property :note

  # validate :whether_vendor_already_has_recurring_income

  validates :amount, presence: true
  validates :user_id, presence: true
  validates :vendor_id, presence: true
  validates :income_category_id, presence: true
  validates :created_at, presence: true
  validates :frequency, presence: true

  def whether_vendor_already_has_recurring_income
    if RecurringIncome.where(vendor_id: self.vendor_id).count > 0
      errors.add(:vendor_id, "is already in use")
    end
  end
end
