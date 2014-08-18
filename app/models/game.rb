require "people_generator"

##
# An individual game. Select 10 random people and present them with a mixture
# of names. Track how well the player is doing then give them their score.
class Game < ActiveRecord::Base
  cattr_writer :element_generator
  attr_reader :guess

  has_many :questions

  ##
  # Generate n random Person objects, all unique, using the element_generator,
  # and stash them as Questions.
  def randomize_list(n)
    people = self.class.element_generator.generate(n, excluded_office: excluded_office)

    people.each.with_index do |person, position|
      questions.create(person: person, position: position)
    end
  end

  ##
  # Produce the next unanswered Question.
  def next_question
    questions.by_position.find_by(guessed_person_id: nil)
  end

  ##
  # Produce the most-recently-answered Question.
  def previous_question
    questions.by_position.where.not(guessed_person_id: nil).last || NullQuestion.new
  end

  ##
  # Update the next Question with the answer.
  def guess=(person_id)
    next_question.update(guessed_person_id: person_id)
  end

  private

  def self.element_generator
    @@element_generator || PeopleGenerator.new
  end
end
