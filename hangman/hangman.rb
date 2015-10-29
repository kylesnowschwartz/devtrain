require './gamestate.rb'
require './gameview.rb'

class Hangman
  def initialize(view, state)
    @state = state
    @view = view
  end

  def play
    @view.begin_game(@state)

    until @state.finished?
      take_turn
    end

    if @state.lives_remaining == 0
      @view.report_game_lost
    else
      @view.report_game_won
    end
  end

  private

  def take_turn
    if @state.submit_guess(@view.ask_for_letter)
      @view.report_correct_guess(@state)
    else
      @view.report_incorrect_guess(@state)
    end
  end
end

lives = 8
word = "bottle"
view = GameView.new(STDIN, STDOUT)
state = GameState.new(lives, word)
hangman = Hangman.new(view, state)

hangman.play if __FILE__==$0 #plays hangman if only called from command line