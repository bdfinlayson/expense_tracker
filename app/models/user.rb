class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :budgets
  has_many :vendors
  has_many :expenses
  has_many :expense_categories
  has_many :recurring_expenses
  has_many :incomes
  has_many :income_categories
  has_many :recurring_incomes
end
