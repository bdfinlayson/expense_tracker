class IncomeCategory < ApplicationRecord
  has_many :incomes
  has_many :recurring_incomes
  belongs_to :user
end
