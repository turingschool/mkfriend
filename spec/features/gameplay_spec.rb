require "spec_helper"

feature "gameplay" do
  context "when submitting without choosing a guess" do
    it "selects the first person" do
      person = create(:person)
      next_person = create(:person)
      start_game_with [person, next_person]

      guess_without_choosing_anyone

      expect(page).to show_image_for(next_person)
    end
  end

  context "an incorrect or incorrect guess" do
    it "shows the trivia, bio, and image for the previous person" do
      person = create(:person, bio: "Radical", trivia: "trivia1\ntrivia2")
      start_game_with [person, create(:person)]

      guess(person.name)

      expect_to_show_trivia_for(person)
      expect(page).to have_content(person.bio)
      expect(page).to show_image_for(person)
    end

    it "shows the next person" do
      person = create(:person)
      next_person = create(:person)
      start_game_with [person, next_person]

      guess(person.name)

      expect(page).to show_image_for(next_person)
    end
  end

  context "a correct guess" do
    scenario "shows that you are correct" do
      person = create(:person)
      next_person = create(:person)
      start_game_with [person, next_person]

      guess(person.name)

      expect(page).to have_content("Correct!")
    end
  end

  context "an incorrect guess" do
    scenario "shows that you are incorrect" do
      person = create(:person)
      next_person = create(:person)
      start_game_with [person, next_person]

      guess_incorrectly(person.name)

      expect(page).to have_content("Nope, that's wrong")
    end
  end

  context "after finishing a game" do
    scenario "it shows the percentage correct" do
      first_person = create(:person)
      second_person = create(:person)
      start_game_with [first_person, second_person]

      2.times { guess(first_person.name) }

      expect(page).to have_content("50.0% right - you got 1 wrong")
    end
  end

  ##
  # Start a game with the given people, who will be displayed in order.
  def start_game_with(people)
    stack_randomizer people

    visit root_url
    click_button "Start"
  end

  ##
  # Guess at the person currently displayed
  def guess(name)
    choose(name)
    click_button("Guess")
  end

  ##
  # Submit without choosing a person.
  def guess_without_choosing_anyone
    click_button("Guess")
  end

  ##
  # Make an incorrect guess.
  def guess_incorrectly(correct_guess)
    label = all("form label").detect { |tag| ! tag.text.include?(correct_guess) }
    guess(label.text)
  end

  ##
  # Just start a game, no fanciness.
  def start_game
    start_game_with create_pair(:person)
  end

  ##
  # Are all of the trivia for this person being shown?
  def expect_to_show_trivia_for(person)
    person.trivia.each do |trivium|
      expect(page).to have_css("li", text: trivium)
    end
  end
end
