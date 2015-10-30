class GameState
	attr_reader :word, :lives_remaining, :guessed_letters, :board

	def initialize(lives, word)
		raise ArgumentError, "The word must have 3 or more letters" unless word.length >= 3
		raise ArgumentError, "The number of lives must be greater than zero" unless lives > 0

		@word = break_word_into_letters(word) # TODO This is letters, not a word
		@guessed_letters = []
		@lives_remaining = lives
		@board = board_for(@word)
	end

	def finished?
	  @lives_remaining == 0 || letters_remaining.empty?
	end

	def submit_guess(guess)
	  @guessed_letters << guess

	  if @word.include?(guess)
	    replace_blank_tile_with_guessed_letter(guess)
	    true
	  else
	    subtract_life
	    false
	  end
	end

	def letters_remaining
		@word - @guessed_letters
	end

	private

	def replace_blank_tile_with_guessed_letter(guess)
	  all_indexes_for_letter(guess).each { |index| @board[index] = @word[index] }
	end

	def subtract_life
	  @lives_remaining -= 1
	end

	def all_indexes_for_letter(letter)
	  @word.each_index.select { |index| @word[index] == letter } # =>[0, 2, 6] etc
	end

	def break_word_into_letters(word)
	  word.upcase.chars
	end

	def board_for(word)
		word.map { "_" }
	end
end