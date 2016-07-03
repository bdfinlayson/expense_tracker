class Category < ApplicationRecord
  has_ancestry
  has_many :expenses
  validates_presence_of :name, :user_id
end
