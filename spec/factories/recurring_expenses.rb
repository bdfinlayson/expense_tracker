FactoryGirl.define do
  factory :recurring_expense do
    amount 100.00
    vendor
    user
    expense_category
    note 'This is a recurring expense note'
    frequency 2
  end
end
