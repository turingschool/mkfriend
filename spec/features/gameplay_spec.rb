require "spec_helper"

feature "gameplay" do
  it "lets users choose an office to not view" do
    boston = create(:person, office: "Boston")
    denver = create(:person, office: "Denver")

    visit root_url
    select "Denver", from: "Office to exclude"
    click_button "Start"

    expect(page).to show_image_for(boston)

    guess(boston.name)

    expect_game_to_be_over
  end

 it "shows all users when users do not choose an office to exclude" do
   boston = create(:person, office: "Boston")
   denver = create(:person, office: "Denver")

   visit root_url
   click_button "Start"

   guess(boston.name)
   guess(boston.name)

   expect_game_to_be_over
 end

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

      guess_incorrectly

      expect(page).to have_content("Nope, that's wrong")
    end
  end

  context "after finishing a game" do
    scenario "it shows the percentage correct" do
      first_person = create(:person)
      start_game_with([first_person])

      guess(first_person.name)
      guess_remaining_people_incorrectly

      expect(page).to have_content("10.0% right - you got 9 wrong")
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

  def guess_remaining_people_incorrectly
    while guessing?
      guess_incorrectly
    end
  end

  ##
  # Are we still guessing people, or is the game over?
  def guessing?
    ! page.has_content?("Your Results")
  end

  ##
  # Make an incorrect guess
  def guess_incorrectly
    correct_guess = Game.first.next_question.person.name

    tag = all("form label").detect do |tag|
      ! tag.text.include?(correct_guess)
    end

    guess(tag.text)
  end

  ##
  # Assert that the game is over.
  def expect_game_to_be_over
    expect(page).to have_content("Your Results")
  end
end
