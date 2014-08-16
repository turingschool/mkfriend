require "spec_helper"

describe Game do
  context "#randomize_list" do
    it "generates the expected number of unique items" do
      create_list(:person, 3)
      game = create(:game)
      game.randomize_list(2)
      questions = game.questions

      expect(questions.count).to eq(2)
      expect(questions[0]).not_to eq(questions[1])
    end
  end

  context "#next_question" do
    it "produces the next unanswered Question" do
      question = create(:question, guessed_person_id: 2)
      game = question.game
      next_question = create(:question, game: game)

      expect(game.next_question).to eq(next_question)
    end

    it "produces false when all Questions have been answered" do
      question = create(:question, guessed_person_id: 2)
      game = question.game

      expect(game.next_question).to be_falsey
    end

    it "produces false when the Game has no Questions" do
      game = create(:game)
      expect(game.next_question).to be_falsey
    end
  end

  context "#previous_question" do
    it "is the most recent answered question" do
      game = create(:game)
      create(:question, game: game, guessed_person_id: 3)
      question = create(:question, game: game, guessed_person_id: 3)
      create(:question, game: game, guessed_person_id: nil)

      expect(game.previous_question).to eq question
    end
  end


  context "#guess=" do
    it "assigns the guess to the next unanswered Question" do
      question = create(:question)
      game = question.game

      game.guess = 2

      expect(game.reload.questions.last.guessed_person_id).to eq(2)
    end
  end
end
