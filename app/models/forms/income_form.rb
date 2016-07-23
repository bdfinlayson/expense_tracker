require 'reform/form/coercion'

class IncomeForm < Reform::Form
  include Coercion
  property :amount
  property :user_id
  property :vendor_id
  property :frequency, type: Integer
  property :recurring

  validates :amount, presence: true
  validates :user_id, presence: true
  validates :vendor_id, presence: true
  validates :frequency, presence: true
  validates :recurring, presence: true
end
