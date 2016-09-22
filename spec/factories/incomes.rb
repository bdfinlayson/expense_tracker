FactoryGirl.define do
  factory :income do
    user
    vendor
    amount 100
    created_at Time.now
  end
end
