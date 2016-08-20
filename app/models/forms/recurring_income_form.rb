class IncomeForm < Reform::Form
  property :amount
  property :user_id
  property :vendor_id
  property :frequency
  property :recurring
  property :created_at

  validates :amount, presence: true
  validates :user_id, presence: true
  validates :vendor_id, presence: true
  validates :created_at, presence: true
  validates :frequency, presence: true, if: :recurring
end
