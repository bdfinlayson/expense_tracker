FactoryGirl.define do
  factory :recurring_income do
    amount 100.00
    vendor
    user
    income_category
    note 'This is recurring income'
    frequency 2
  end
end
