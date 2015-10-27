require './gamestate.rb'

class Hangman
  attr_reader :word

  def initialize(lives, word)
    raise ArgumentError.new("The number of lives must be greater than zero") unless lives > 0
    raise ArgumentError.new("The word must have 3 or more letters") unless word.chars.count > 2
    @word = parse_word(word)
    @game_state = GameState.new(lives, @word)
  end

  def play
    clear_screen
    puts "Welcome to hangman. Guess a letter."
    @game_state.print_board
    until @game_state.finished?
      take_turn
    end
    report_game_result
  end

  private

  def take_turn
    if @game_state.submit_guess(ask_for_letter)
      clear_screen
      report_success
    else
      clear_screen
      report_failure
    end
    @game_state.print
  end

  def ask_for_letter
    alphabet = ('A'..'Z').to_a
    while user_input = gets.upcase.chomp
      if alphabet.include?(user_input)
        return user_input
      else
        puts "Please select a single letter in the English alphabet:"
      end
    end
  end

  def report_success
    puts "You guessed correctly!"
  end

  def report_failure
    puts "Sorry, you guessed incorrectly"
  end

  def print_line
    puts "_" * 40
  end

  def clear_screen
    system "clear"
  end

  def report_game_result
    if @game_state.lives_remaining == 0
      puts "Sorry, you're dead."
    else
      puts "You guessed correctly! You live to see another day"
    end
  end

  def parse_word(word)
    word.upcase.chars
  end
end

hangman = Hangman.new(8, "bottle")

hangman.play if __FILE__==$0 #plays hangman if only called from command line