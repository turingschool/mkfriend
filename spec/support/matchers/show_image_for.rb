##
# Matchers for showing a person's image.
module ShowImageFor
  ##
  # Is the image URL for the Person on the page?
  def show_image_for(person)
    have_css("img[src='#{person.image_url}']")
  end
end

RSpec.configure do |config|
  config.include ShowImageFor, type: :feature
end
