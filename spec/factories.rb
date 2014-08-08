FactoryGirl.define do
  sequence :name do |n|
    "Gustav #{n}"
  end

  sequence :image_url do |n|
    "https://example.com/people/#{n}.jpg"
  end

  sequence(:position) { |n| n }

  factory :person do
    name
    image_url
  end

  factory :game

  factory :question do
    game
    person
    position
  end
end
