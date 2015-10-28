class Hangman
	def initialize(lives, word, input, output)
		@lives = lives
		@word = word
		@output = output
		@input = input
	end

	def play
		
		@output.puts "Welcome to hangman."
		@guesses = []
		while (guess = read_a_guess)
			@guesses << guess
			if @word.include?(guess)
				if won?
					@output.puts "You won: the word was \"#{@word}\"."
					return
				end
			else
				@lives -= 1
				if @lives.zero?
					@output.puts "Sorry, you lost. The word was \"#{@word}\"."
					return
				end
			end
		end
	end

	private

	def won?
		@guesses.uniq.sort == @word.chars.uniq.sort
	end

	def dashes
		@word.chars.map { |c| @guesses.include?(c) ? c : "_" }.join(" ")
	end

	def read_a_guess
		@output.puts "#{@lives} lives remaining.
#{dashes}
Please enter a letter:
"
		if string = @input.gets
			return string.chomp
		end

	end
end

Hangman.new(5, "banana", STDIN, STDOUT).play if __FILE__ == $0