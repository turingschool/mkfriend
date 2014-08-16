##
# A puzzle presented to the user: who is this person?
class Question < ActiveRecord::Base
  belongs_to :game
  belongs_to :person
  belongs_to :guessed_person, class_name: "Person"

  delegate :image_url, :description, to: :person

  ##
  # Order by position, ascending
  def self.by_position
    order(:position)
  end

  ##
  # Four unique Person objects, exactly one of which is our Person.
  def guesses
    (three_guesses + [person]).shuffle
  end

  ##
  # Did the player guess correctly?
  def correct?
    person_id == guessed_person_id
  end

  private

  def three_guesses
    Person.where.not(id: person.id).order("RANDOM()").limit(3)
  end
end
