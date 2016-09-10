FactoryGirl.define do
  factory :pending_expense do
    amount 50.00
    user
    vendor
    expense_category
    recurring_expense
    cleared false
    note 'this is a pending expense note'
  end
end
