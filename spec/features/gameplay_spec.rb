require "spec_helper"

feature "gameplay" do
  scenario "a guess" do
    person = create(:person, name: "Mike Burns")
    next_person = create(:person, image_url: "http://example.com/2")
    create_list(:person, 2)
    stack_randomizer [person, next_person]

    visit root_url
    click_button "Start"

    choose("Mike Burns")
    click_button("Guess")

    expect(page).to show_person(next_person)
  end

  scenario "the last guess" do
    person = create(:person, name: "Joe Ferris")
    stack_randomizer [person]

    visit root_url
    click_button "Start"

    Question.where.not(person_id: person.id).each do |question|
      question.update(guessed_person_id: person.id)
    end

    choose("Joe Ferris")
    click_button("Guess")

    expect(page).to have_content("Your Results")
  end
end
