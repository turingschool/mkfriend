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
    bio "I am cool"
    image_url
    name
    office "Boston"
  end

  factory :game

  factory :question do
    game
    person
    position

    trait :correct do
      person_id 1
      guessed_person_id 1
    end

    trait :incorrect do
      person_id 1
      guessed_person_id 2
    end
  end
end
