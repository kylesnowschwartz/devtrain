class GameState
	attr_reader :lives_remaining, :guessed_letters, :board

	def initialize(lives, word)
		raise ArgumentError, "The word must have 3 or more letters" unless word.length >= 3
		raise ArgumentError, "The number of lives must be greater than zero" unless lives > 0

		@letters = break_word_into_letters(word)
		@guessed_letters = []
		@lives = lives
		@board = board_for(@letters)
	end

	def finished?
	  dead? || letters_remaining.empty?
	end

	def submit_guess(guess)
	  @guessed_letters << guess

	  if @letters.include?(guess)
	    replace_blank_tile_with_guessed_letter(guess)
	    true
	  else
	    false
	  end
	end

	def dead?
		lives_remaining == 0
	end

	def lives_remaining
		@lives - (@guessed_letters - @letters).count
	end

	def letters_remaining
		@letters - @guessed_letters
	end

	private

	def replace_blank_tile_with_guessed_letter(guess)
	  all_indexes_for_letter(guess).each { |index| @board[index] = @letters[index] }
	end


	def all_indexes_for_letter(letter)
	  @letters.each_index.select { |index| @letters[index] == letter } # =>[0, 2, 6] etc
	end

	def break_word_into_letters(word)
	  word.upcase.chars
	end

	def board_for(letters)
		letters.map { "_" }
	end
end