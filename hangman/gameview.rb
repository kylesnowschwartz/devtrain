class GameView
	def begin_game(state)
		clear_screen
		puts "Welcome to hangman. Guess a letter."
		print_board(state)
	end

	def report_game_lost
    puts "Sorry, you're dead."
	end

	def report_game_won
    puts "You guessed correctly! You live to see another day"
	end

	def report_correct_guess(state)
		clear_screen
	  puts "You guessed correctly!"
	  print_gamestate(state)
	end

	def report_incorrect_guess(state)
		clear_screen
	  puts "Sorry, you guessed incorrectly"
	  print_gamestate(state)
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

	def print_line
	  puts "_" * 40
	end

	def print_gamestate(state)
	  puts "Thusfar, you've guessed:"
	  puts state.guessed_letters.uniq.join(" ")
	  puts "You have #{state.remaining_letters.length} letters remaining"
	  puts "You have #{state.lives_remaining} lives remaining"
	  print_board(state)
	  puts "Guess Again:" unless state.finished?
	end

	def print_board(state)
	  puts state.board.join(" ")
	end

	def clear_screen
	  system "clear"
	end
end