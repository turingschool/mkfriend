require "spec_helper"

describe Person do
  context "#trivia" do
    it "returns trivia split on newlines" do
      person = create(:person, trivia: "one\ntwo")

      expect(person.trivia).to eq %w(one two)
    end
  end
end
