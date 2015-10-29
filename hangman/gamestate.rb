class GameState
	attr_reader :word, :lives_remaining, :guessed_letters, :remaining_letters, :board

	def initialize(lives, word)
		raise ArgumentError, "The number of lives must be greater than zero" unless lives > 0
		raise ArgumentError, "The word must have 3 or more letters" unless word.chars.count > 2
		@word = parse_word(word)
		@guessed_letters = []
		@lives_remaining = lives
		@board = @word.map {|e| "_"}
	end

	def subtract_life
	  @lives_remaining -= 1
	end

	def finished?
	  (@lives_remaining == 0) || letters_remaining.empty?
	end

	def replace_blank_tile_with_guessed_letter(guess)
	  indexes = @word.each_index.select{|index| @word[index] == guess} # =>[0, 2, 6] etc
	  indexes.each {|index| @board[index] = @word[index]}
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

	def parse_word(word)
	  word.upcase.chars
	end
end