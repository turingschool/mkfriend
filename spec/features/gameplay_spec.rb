require "spec_helper"

feature "gameplay" do
  context "a correct guess" do
    scenario "shows that you are correct" do
      person = create(:person, name: "Mike Burns", trivia: "trivia1\ntrivia2", bio: "Awesome.")
      next_person = create(:person, image_url: "http://example.com/2")
      create_list(:person, 2)
      stack_randomizer [person, next_person]

      visit root_url
      click_button "Start"

      choose(person.name)
      click_button("Guess")

      expect(page).to have_content("Correct!")
      expect_to_show_trivia_for(person)
      expect(page).to have_content(person.bio)
      expect(page).to show_person(person)
      expect(page).to show_person(next_person)
    end
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

  ##
  # Are all of the trivia for this person being shown?
  def expect_to_show_trivia_for(person)
    person.trivia.each do |trivium|
      expect(page).to have_css("li", text: trivium)
    end
  end
end
