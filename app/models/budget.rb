class Budget < ApplicationRecord
  belongs_to :user
  belongs_to :category
  validates_presence_of :amount, :user_id, :category_id
  validates_uniqueness_of :category_id
end
