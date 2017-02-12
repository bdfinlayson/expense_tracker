FactoryGirl.define do
  factory :account_payable do
    starting_amount 1.5
    current_amount 1.5
    name "MyString"
    user_id 1
    interest_free_expiration_at "2017-02-11"
    opened_at "2017-02-11"
    closed_at "2017-02-11"
    vendor_id 1
  end
end
