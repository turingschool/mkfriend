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

  context "#correct?" do
    it "is true when the person and guessed person have the same id" do
      correct_question = create(:question)
      correct_question.update(guessed_person_id: correct_question.person_id)

      wrong_question = create(:question)
      wrong_question.update(guessed_person_id: wrong_question.person_id + 1)

      expect(correct_question).to be_correct
      expect(wrong_question).not_to be_correct
    end
  end
end
