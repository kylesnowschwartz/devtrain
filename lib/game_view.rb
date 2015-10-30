class GameView # TODO underscores for file name
	attr_reader :state

	ALPHABET = ('A'..'Z')

	def initialize(input, output, state)
		@input = input
		@output = output
		@state = state
	end

	def begin_game
		@state = state
		clear_screen
		print "Welcome to hangman. Guess a letter."
		print_board
	end

	def ask_for_letter
	  while user_input = @input.gets.upcase.chomp # TODO get_normalized_input
	    return user_input if valid_letter?(user_input)
      report_invalid_input
	  end
	end

	def report_correct_guess
		clear_screen
	  print "You guessed correctly!"
	  print_gamestate
	end

	def report_incorrect_guess
		clear_screen
	  print "Sorry, you guessed incorrectly"
	  print_gamestate
	end

	def report_game_lost
    print "Sorry, you're dead."
	end

	def report_game_won
    print "You guessed correctly! You live to see another day"
	end
	
private

	def valid_letter?(letter)
	  ALPHABET.include?(letter)
	end

	# TODO test this method
	def print_gamestate
	  print "Thusfar, you've guessed:"
	  print state.guessed_letters.uniq.join(" ") # TODO .guessed_letters.stringify
	  print "You have #{state.letters_remaining.length} letters remaining" # TODO Grammar.
	  print "You have #{state.lives_remaining} lives remaining"
	  print_board
	  print "Guess Again:" unless state.finished?
	end

	def print_board
	  print state.board.join(" ")
	end

	def clear_screen
	  system "clear"
	end

	def print(string)
		@output.puts string
	end

	def report_invalid_input
		print "Please select a single letter in the English alphabet:"
	end
end