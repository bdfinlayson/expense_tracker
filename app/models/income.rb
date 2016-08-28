class Income < ApplicationRecord
  include BaseModel
  belongs_to :user
  belongs_to :vendor
  belongs_to :income_category
  belongs_to :recurring_income
  validates_presence_of :income_category_id, :vendor_id, :user_id
end
