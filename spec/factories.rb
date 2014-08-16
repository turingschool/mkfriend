FactoryGirl.define do
  sequence :name do |n|
    "Gustav #{n}"
  end

  sequence :image_url do |n|
    "https://example.com/people/#{n}.jpg"
  end

  sequence(:position) { |n| n }

  factory :person do
    sequence(:slug) { |n| "slug#{n}" }
    name
    image_url
    bio "I am cool"
  end

  factory :game

  factory :question do
    game
    person
    position
  end
end
