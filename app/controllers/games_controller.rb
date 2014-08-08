##
# Create a new game, play through a game, and present the result.
class GamesController < ApplicationController
  ##
  # Prompt the user to start the game, explaining what it is.
  def new
    @game = Game.new
  end

  ##
  # Generate a list of 10 random people and start the user down the path of
  # guesswork and frustration.
  def create
    game = Game.new
    if game.save && game.randomize_list(10)
      redirect_to edit_game_url(game)
    else
      render :new, error: "failed to start the game"
    end
  end

  ##
  # Prompt the player with a question, await their guess.
  def edit
    @game = Game.find(params[:id])
    @question = @game.next_question
  end

  ##
  # Save the guess, offer another one if it exists.
  def update
    game = Game.find(params[:id])
    game.update(game_attributes)
    redirect_to edit_game_path(game)
  end

  private

  def game_attributes
    params.require(:game).permit(:guess)
  end
end
