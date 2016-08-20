class BudgetForm < Reform::Form
  property :amount
  property :expense_category_id
  property :user_id

  validates :amount, presence: true
  validates :expense_category_id, presence: true
  validates :user_id, presence: true
end
