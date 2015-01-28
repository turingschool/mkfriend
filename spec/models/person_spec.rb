require "spec_helper"

describe Person do
  context ".all_cohort_names" do
    it "orders them alphabetically" do
      create(:person, cohort: "Denver")
      create(:person, cohort: "Boston")

      expect(Person.all_cohort_names).to eq %w(Boston Denver)
    end

    it "does not have duplicates" do
      create_pair(:person, cohort: "Boston")

      expect(Person.all_cohort_names).to eq %w(Boston)
    end

    it "does not include NULLs" do
      create(:person, cohort: nil)

      expect(Person.all_cohort_names).to be_empty
    end
  end

  context ".with_all_cohorts_except" do
    it "finds all people that are not in a given cohort" do
      create(:person, cohort: "Denver")
      boston = create(:person, cohort: "Boston")

      expect(Person.with_all_cohorts_except("Denver")).to eq [boston]
    end
  end
end
