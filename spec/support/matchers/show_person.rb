##
# Matchers for showing a person.
module ShowPerson
  ##
  # Is the image URL for the Person on the page?
  def show_person(person)
    have_css("img[src='#{person.image_url}']")
  end
end

RSpec.configure do |config|
  config.include ShowPerson, type: :feature
end
