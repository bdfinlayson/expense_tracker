class ExpenseCategory < ApplicationRecord
  has_one :budget
  validates_presence_of :name, :user_id
  has_many :expenses
  has_many :recurring_expenses
  belongs_to :user
  default_scope -> { order('lower(name) asc') }

  def summed_expenses(month = Time.now.month, year = Time.now.year)
    self.expenses.where('extract(year from created_at) = ?', year).where('extract(month from created_at) = ?', month).pluck(:amount).sum
  end
end
