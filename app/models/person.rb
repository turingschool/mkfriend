class Person < ActiveRecord::Base
  TRIVIA_SEPARATOR = "\n"

  validates :slug, presence: true
  validates :image_url, presence: true
  validates :bio, presence: true

  def self.all_office_names
    select('DISTINCT office').
      order(:office).
      where.not(office: nil).
      map(&:office)
  end

  def self.with_all_offices_except(office_name)
    where.not(office: office_name)
  end

  def trivia
    self[:trivia].split(TRIVIA_SEPARATOR)
  end
end
