require 'reform/form/coercion'

class ExpenseForm < Reform::Form
  feature Coercion
  property :amount
  property :user_id
  property :vendor_id, type: Types::Form::Int
  property :expense_category_id, type: Types::Form::Int
  property :created_at
  property :recurring_expense_id, type: Types::Form::Int
  property :note

  validates :amount, presence: true
  validates :user_id, presence: true
  validates :vendor_id, presence: true
  validates :category_id, presence: true
  validates :created_at, presence: true
end
