require "spec_helper"

describe PeopleGenerator do
  context "#generate" do
    it "produces n unique Person objects" do
      create_list(:person, 3)
      generator = PeopleGenerator.new
      people = generator.generate(2, excluded_office: nil)

      expect(people.count).to eq(2)
      expect(people[0]).not_to eq(people[1])
    end

    it "can exclude an office" do
      boston = create(:person, office: "Boston")
      denver = create(:person, office: "Denver")

      generator = PeopleGenerator.new
      people = generator.generate(2, excluded_office: "Boston")

      expect(people).to eq [denver]
    end
  end
end
