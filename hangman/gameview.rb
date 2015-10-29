class GameView
	ALPHABET = ('A'..'Z').to_a

	def initialize(input, output)
		@input = input
		@output = output
	end

	def begin_game(state)
		clear_screen
		@output.puts "Welcome to hangman. Guess a letter."
		print_board(state)
	end

	def report_game_lost
    @output.puts "Sorry, you're dead."
	end

	def report_game_won
    @output.puts "You guessed correctly! You live to see another day"
	end

	def report_correct_guess(state)
		clear_screen
	  @output.puts "You guessed correctly!"
	  print_gamestate(state)
	end

	def report_incorrect_guess(state)
		clear_screen
	  @output.puts "Sorry, you guessed incorrectly"
	  print_gamestate(state)
	end

	def ask_for_letter
	  while user_input = @input.gets.upcase.chomp
	    if validate_letter(user_input)
	      return user_input
	    else
	      @output.puts "Please select a single letter in the English alphabet:"
	    end
	  end
	end

	def validate_letter(letter)
	  ALPHABET.include?(letter)
	end

	def print_gamestate(state)
	  @output.puts "Thusfar, you've guessed:"
	  @output.puts state.guessed_letters.uniq.join(" ")
	  @output.puts "You have #{state.remaining_letters.length} letters remaining"
	  @output.puts "You have #{state.lives_remaining} lives remaining"
	  print_board(state)
	  @output.puts "Guess Again:" unless state.finished?
	end

	def print_board(state)
	  @output.puts state.board.join(" ")
	end

	def clear_screen
	  system "clear"
	end
end