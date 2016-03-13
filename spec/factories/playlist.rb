FactoryGirl.define do
  factory :playlist do
    sequence(:name) {|n| "playlist ##{n}"}
    user
  end
end
