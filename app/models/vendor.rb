class Vendor < ApplicationRecord
  has_many :expenses
  has_many :incomes
  has_one :account_payable
  belongs_to :user
  validates_presence_of :name, :user_id
  validates :name, uniqueness: { scope: :user_id, message: 'Cannot have two vendors with the same name' }
  default_scope -> { order('lower(name) asc') }
end
