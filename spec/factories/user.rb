FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@email.com"}
    password 'test1234'
    user_type 0
  end
end
