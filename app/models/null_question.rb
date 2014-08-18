##
# A null question that is associated with a NullPerson.
class NullQuestion
  def person
    NullPerson.new
  end
end
