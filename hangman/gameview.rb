class GameView

	def initialize(state)
		@state = state
	end

	def ask_for_letter
	  while user_input = gets.upcase.chomp
	    if validate_letter(user_input)
	      return user_input
	    else
	      puts "Please select a single letter in the English alphabet:"
	    end
	  end
	end

	def validate_letter(letter)
	  alphabet = ('A'..'Z').to_a
	  alphabet.include?(letter)
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
	  if @state.lives_remaining == 0
	    puts "Sorry, you're dead."
	  else
	    puts "You guessed correctly! You live to see another day"
	  end
	end

	def print_gamestate
	  puts "Thusfar, you've guessed:"
	  puts @state.guessed_letters.uniq.join(" ")
	  puts "You have #{@state.remaining_letters.length} letters remaining"
	  puts "You have #{@state.lives_remaining} lives remaining"
	  print_board
	  puts "Guess Again:" unless @state.finished?
	end

	def print_board
	  puts @state.board.join(" ")
	end
end