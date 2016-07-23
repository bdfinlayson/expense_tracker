class Income < ApplicationRecord
  belongs_to :user
  belongs_to :vendor
  enum frequency: [:weekly, :biweekly, :monthly, :annually]
end
