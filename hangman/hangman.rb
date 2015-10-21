class Hangman
  attr_reader :word, :lives_remaining, :guessed_letters, :remaining_letters, :board

  def initialize(lives, word)
    @word = parse_word(word)
    @lives_remaining = lives
    @guessed_letters = []
    @remaining_letters = parse_word(word)
    @board = @word.map {|e| "_"}
  end

  def play
    clear_screen
    puts "Welcome to hangman. Guess a letter."
    print_board
    until finished?
      take_turn
    end
    report_game_result
  end

  private

  def take_turn
    if submit_guess(ask_for_letter)
      report_success
    else
      report_failure
    end
    print_gamestate
  end

  def submit_guess(guess)
    @guessed_letters << guess
    if @word.include?(guess)
      @remaining_letters = @remaining_letters - [guess]
      replace_blank_tile_with_guessed_letter(guess)
      true
    else
      subtract_life
      false
    end
  end

  def ask_for_letter
    player_guess = gets.chomp
  end

  def report_success
    puts "You guessed correctly!"
  end

  def report_failure
    puts "Sorry, you guessed incorrectly"
  end

  def print_gamestate
    clear_screen
    puts "Thusfar, you've guessed:"
    p @guessed_letters.uniq
    puts "You have #{@remaining_letters.length} letters remaining"
    puts "You have #{@lives_remaining} lives remaining"
    print_board
    puts "Guess Again:" unless finished?
  end

  def replace_blank_tile_with_guessed_letter(guess)
    indexes = @word.each_index.select{|i| @word[i] == guess} # =>[0, 2, 6] etc
    indexes.each {|index| @board[index] = @word[index]}
  end

  def print_board
    puts @board.join(" ")
  end

  def print_line
    puts "_" * 40
  end

  def clear_screen
    system "clear"
  end

  def finished?
    (@lives_remaining == 0) || ((@guessed_letters & @word).sort == @word.uniq.sort)
  end

  def report_game_result
    if @lives_remaining == 0
      puts "Sorry, you're dead."
    else
      puts "You guessed correctly! You live to see another day"
    end
  end

  def parse_word(word)
    word.chars
  end

  def subtract_life
    @lives_remaining -= 1
  end
end

hangman = Hangman.new(8, "bottle")

hangman.play if __FILE__==$0 #plays hangman if only called from command line