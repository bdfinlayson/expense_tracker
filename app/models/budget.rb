class Budget < ApplicationRecord
  include BaseModel
  belongs_to :user
  belongs_to :expense_category
  validates_presence_of :amount, :user_id, :expense_category_id
  validates_uniqueness_of :expense_category_id
end
