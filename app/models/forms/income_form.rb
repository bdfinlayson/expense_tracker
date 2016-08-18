require 'reform/form/coercion'

class IncomeForm < Reform::Form
  feature Coercion
  property :amount
  property :user_id
  property :vendor_id, type: Types::Form::Int
  property :created_at
  property :income_category_id, type: Types::Form::Int
  property :recurring_income_id, type: Types::Form::Int

  validates :amount, presence: true
  validates :user_id, presence: true
  validates :vendor_id, presence: true
  validates :created_at, presence: true
  validates :income_category_id, presence: true
end
