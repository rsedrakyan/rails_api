FactoryGirl.define do
  factory :track do
    sequence(:name) {|n| "playlist ##{n}"}
    url 'http://some_address.com/track'
    author 'Some author'
    playlist
  end
end
