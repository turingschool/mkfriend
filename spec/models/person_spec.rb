require "spec_helper"

describe Person do
  context "#trivia" do
    it "returns trivia split on newlines" do
      person = create(:person, trivia: "one\ntwo")

      expect(person.trivia).to eq %w(one two)
    end
  end

  context ".all_office_names" do
    it "orders them alphabetically" do
      create(:person, office: "Denver")
      create(:person, office: "Boston")

      expect(Person.all_office_names).to eq %w(Boston Denver)
    end

    it "does not have duplicates" do
      create_pair(:person, office: "Boston")

      expect(Person.all_office_names).to eq %w(Boston)
    end

    it "does not include NULLs" do
      create(:person, office: nil)

      expect(Person.all_office_names).to be_empty
    end
  end

  context ".with_all_offices_except" do
    it "finds all people that are not in a given office" do
      create(:person, office: "Denver")
      boston = create(:person, office: "Boston")

      expect(Person.with_all_offices_except("Denver")).to eq [boston]
    end
  end
end
