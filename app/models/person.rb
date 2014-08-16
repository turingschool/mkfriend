class Person < ActiveRecord::Base
  TRIVIA_SEPARATOR = "\n"

  def trivia
    self[:trivia].split(TRIVIA_SEPARATOR)
  end
end
