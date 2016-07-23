class BudgetForm < Reform::Form
  property :amount
  property :category_id
  property :user_id

  validates :amount, presence: true
  validates :category_id, presence: true
  validates :user_id, presence: true
end
