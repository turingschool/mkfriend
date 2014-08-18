##
# Helpers for randomized person testing.
module PersonsHelper
  ##
  # Generate the next n elements for the array, but in a predefined manner.
  class FakeElementGenerator
    ##
    # Generate elements, the first of which much be start_with.
    def initialize(start_with:)
      @start = start_with
    end

    ##
    # Generate n elements. If start_with does not cover it, use FactoryGirl to
    # make the rest.
    def generate(n, excluded_office:)
      diff = n - @start.length
      if diff > 0
        @start + FactoryGirl.create_list(:person, diff)
      else
        @start.first(n)
      end
    end
  end

  ##
  # The first "randomly"-generated objects will be the ones specified as
  # start.
  def stack_randomizer(start)
    fake_generator = FakeElementGenerator.new(start_with: start)
    Game.element_generator = fake_generator
  end
end

RSpec.configure do |config|
  config.include PersonsHelper
end
