##
# Produce n Person objects, randomly sorted, each unique.
class PeopleGenerator
  ##
  # Use SQL to select n random Person objects.
  def generate(n)
    Person.order('RANDOM()').limit(n)
  end
end
