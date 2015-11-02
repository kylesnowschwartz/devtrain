require_relative './game_state.rb'
require_relative './game_view.rb'

class Hangman
  def initialize(view, game)
    @game = game
    @view = view
  end

  def play
    @view.welcome_player

    take_turn until @game.finished?
      
    if @game.zero_lives_remaining?
      @view.report_game_lost
    else
      @view.report_game_won
    end
  end

  private

  def take_turn
    guess = @view.ask_for_letter
    
    if @game.submit_guess(guess)
      @view.report_correct_guess
    else
      @view.report_incorrect_guess
    end
  end
end