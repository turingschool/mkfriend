class Person < ActiveRecord::Base
  validates :slug, presence: true
  validates :image_url, presence: true

  def self.all_cohort_names
    select('DISTINCT cohort').
      order(:cohort).
      where.not(cohort: nil).
      map(&:cohort)
  end

  def self.with_all_cohorts_except(cohort_name)
    where.not(cohort: cohort_name)
  end
end
