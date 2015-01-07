class Person < ActiveRecord::Base
  TRIVIA_SEPARATOR = "\n"

  validates :slug, presence: true
  validates :image_url, presence: true
  validates :bio, presence: true

  def self.all_cohort_names
    select('DISTINCT cohort').
      order(:cohort).
      where.not(cohort: nil).
      map(&:cohort)
  end

  def self.with_all_cohorts_except(cohort_name)
    where.not(cohort: cohort_name)
  end

  def trivia
    self[:trivia].split(TRIVIA_SEPARATOR)
  end
end
