##
# Matchers for showing a person.
module ShowPerson
  ##
  # Is the image URL for the Person on the page?
  def show_person(person)
    have_css("img[src='#{person.image_url}']")
  end

  ##
  # Are all of the trivia for this person being shown?
  def show_trivia_for(person)
    trivia = person.trivia.split("\n")
    matchers = trivia.map do |trivium|
      have_css("li", content: trivium)
    end

    match(matchers)
  end
end

RSpec.configure do |config|
  config.include ShowPerson, type: :feature
end
