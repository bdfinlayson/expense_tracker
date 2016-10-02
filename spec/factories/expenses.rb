FactoryGirl.define do
  factory :expense do
    user
    vendor
    amount 100
    created_at Time.now
  end
end
