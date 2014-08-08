require "spec_helper"

feature "gameplay" do
  scenario "a right match" do
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
end
