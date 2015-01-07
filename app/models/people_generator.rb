##
# Produce n Person objects, randomly sorted, each unique. Optionally, exclude
# people from a given cohort.
class PeopleGenerator
  ##
  # Use SQL to select n random Person objects, excluding a specific
  # cohort. To include all cohorts, pass `nil` as the cohort to exclude.
  def generate(n, excluded_cohort:)
    Person.
      order('RANDOM()').
      where.not(cohort: excluded_cohort).
      limit(n)
  end
end
