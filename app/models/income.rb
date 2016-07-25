class Income < ApplicationRecord
  belongs_to :user
  belongs_to :vendor
  enum frequency: [:weekly, :biweekly, :monthly, :annually]
  validates_inclusion_of :recurring, :in => [true], if: 'frequency.present?'
end
