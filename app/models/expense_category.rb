class ExpenseCategory < ApplicationRecord
  has_one :budget
  validates_presence_of :name, :user_id
  has_many :expenses
  has_many :recurring_expenses
  belongs_to :user
  default_scope -> { order('lower(name) asc') }

  def summed_expenses
    self.expenses.where(created_at: Time.now.beginning_of_month..Time.now.end_of_month).pluck(:amount).sum
  end
end
