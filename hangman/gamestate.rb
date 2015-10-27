class GameState
	attr_reader :word, :lives_remaining, :guessed_letters, :remaining_letters, :board

	def initialize(lives, word)
		@word = word
		@remaining_letters = word
		@guessed_letters = []
		@lives_remaining = lives
		@board = @remaining_letters.map {|e| "_"}
	end

	def subtract_life
	  @lives_remaining -= 1
	end

	def finished?
	  (@lives_remaining == 0) || ((@guessed_letters & @word).sort == @word.uniq.sort)
	end

	def replace_blank_tile_with_guessed_letter(guess)
	  indexes = @word.each_index.select{|i| @word[i] == guess} # =>[0, 2, 6] etc
	  indexes.each {|index| @board[index] = @word[index]}
	end

	def submit_guess(guess)
	  @guessed_letters << guess
	  if @word.include?(guess)
	    @remaining_letters = @remaining_letters - [guess] # remaining letters/lives as functions
	    replace_blank_tile_with_guessed_letter(guess)
	    true
	  else
	    subtract_life
	    false
	  end
	end
end