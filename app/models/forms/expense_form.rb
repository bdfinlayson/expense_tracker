require 'reform/form/coercion'

class ExpenseForm < Reform::Form
  feature Coercion
  property :amount
  property :user_id
  property :vendor_id
  property :category_id
  property :created_at
  property :recurring, type: Types::Form::Bool
  property :frequency, type: Types::Form::Int

  validates :amount, presence: true
  validates :user_id, presence: true
  validates :vendor_id, presence: true
  validates :category_id, presence: true
  validates :created_at, presence: true
  validates :frequency, presence: true, if: 'recurring.present?'
  validates :recurring, presence: true, if: 'frequency.present?'
end
