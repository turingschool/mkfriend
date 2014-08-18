##
# Produce n Person objects, randomly sorted, each unique. Optionally, exclude
# people from a given office.
class PeopleGenerator
  ##
  # Use SQL to select n random Person objects, excluding a specific
  # office. To include all offices, pass `nil` as the office to exclude.
  def generate(n, excluded_office:)
    Person.
      order('RANDOM()').
      where.not(office: excluded_office).
      limit(n)
  end
end
