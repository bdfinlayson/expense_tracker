class RecurringIncome < ApplicationRecord
  belongs_to :user
  belongs_to :vendor
  belongs_to :income_category
  has_many :incomes
  validates_presence_of :income_category_id, :vendor_id, :user_id, :amount
  accepts_nested_attributes_for :income_category, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :vendor, reject_if: :all_blank, allow_destroy: true
  validates_inclusion_of :recurring, :in => [true], if: 'frequency.present?'
  validates :frequency, presence: true, if: 'recurring.present?'
end
