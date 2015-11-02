require_relative './game_state.rb'
require_relative './game_view.rb'

class Hangman
  def initialize(view, state)
    @state = state # game
    @view = view
  end

  def play
    @view.welcome_player

    take_turn until @state.finished?
      
    if @state.lives_remaining == 0 # player_dead? out of lives?
      @view.report_game_lost
    else
      @view.report_game_won
    end
  end

  private

  def take_turn
    guess = @view.ask_for_letter
    
    if @state.submit_guess(guess)
      @view.report_correct_guess
    else
      @view.report_incorrect_guess
    end
  end
end