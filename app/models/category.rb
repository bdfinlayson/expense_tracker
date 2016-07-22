class Category < ApplicationRecord
  has_many :expenses
  validates_presence_of :name, :user_id

  def summed_expenses
    self.expenses.where(created_at: Time.now.beginning_of_month..Time.now.end_of_month).pluck(:amount).sum
  end
end
