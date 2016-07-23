class Income < ApplicationRecord
  belongs_to :user
  belongs_to :vendor
  enum frequency: [:weekly, :monthly, :annually]
end
