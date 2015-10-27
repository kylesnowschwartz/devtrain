require './gamestate.rb'
require './gameview.rb'

class Hangman
  attr_reader :word

  def initialize(lives, word)
    raise ArgumentError.new("The number of lives must be greater than zero") unless lives > 0
    raise ArgumentError.new("The word must have 3 or more letters") unless word.chars.count > 2
    @word = parse_word(word)
    @state = GameState.new(lives, @word)
    @view = GameView.new(@state) # TODO: inject this as dependancy in constructor
  end

  def play
    @view.clear_screen
    puts "Welcome to hangman. Guess a letter."
    @view.print_board
    until @state.finished?
      take_turn
    end
    @view.report_game_result
  end

  private

  def take_turn
    if @state.submit_guess(@view.ask_for_letter)
      @view.clear_screen
      @view.report_success
    else
      @view.clear_screen
      @view.report_failure
    end
    @view.print_gamestate
  end

  def parse_word(word)
    word.upcase.chars
  end
end

hangman = Hangman.new(8, "bottle")

hangman.play if __FILE__==$0 #plays hangman if only called from command line