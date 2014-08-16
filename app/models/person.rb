class Person < ActiveRecord::Base
  TRIVIA_SEPARATOR = "\n"

  validates :slug, presence: true
  validates :image_url, presence: true
  validates :bio, presence: true

  def trivia
    self[:trivia].split(TRIVIA_SEPARATOR)
  end
end
