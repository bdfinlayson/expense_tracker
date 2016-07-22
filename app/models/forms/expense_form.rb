class ExpenseForm < Reform::Form
  property :amount
  property :user_id
  property :vendor_id
  property :category_id
  property :created_at

  validates :amount, presence: true
  validates :user_id, presence: true
  validates :vendor_id, presence: true
  validates :category_id, presence: true
  validates :created_at, presence: true
end
