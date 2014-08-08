require "spec_helper"

describe Question do
  context "#guesses" do
    it "produces four unique Persons, exactly one of which is our Person" do
      create_list(:person, 4)
      question = create(:question)
      guesses = question.guesses

      expect(guesses.count).to eq(4)
      expect(guesses[0]).not_to eq(guesses[1])
      expect(guesses).to include(question.person)
    end
  end
end
