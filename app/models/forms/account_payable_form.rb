require 'reform/form/coercion'

class AccountPayableForm < Reform::Form
  feature Coercion
  property :current_amount
  property :starting_amount
  property :user_id
  property :vendor_id, type: Types::Form::Int
  property :created_at
  property :interest_free_expiration_at
  property :name

  validates :current_amount, presence: true
  validates :starting_amount, presence: true
  validates :user_id, presence: true
  validates :vendor_id, presence: true
  validates :created_at, presence: true
  validates :name, presence: true
end
