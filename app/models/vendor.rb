class Vendor < ApplicationRecord
  has_many :expenses
  has_many :incomes
  validates_presence_of :name, :user_id
  validates :name, uniqueness: { scope: :user_id, message: 'Cannot have two vendors with the same name' }
end
