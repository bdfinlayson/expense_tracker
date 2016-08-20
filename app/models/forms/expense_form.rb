require 'reform/form/coercion'

class ExpenseForm < Reform::Form
  feature Coercion
  property :amount
  property :user_id
  property :vendor_id
  property :expense_category_id
  property :created_at
  property :note

  validates :amount, presence: true
  validates :user_id, presence: true
  validates :vendor_id, presence: true
  validates :expense_category_id, presence: true
  validates :created_at, presence: true
end
