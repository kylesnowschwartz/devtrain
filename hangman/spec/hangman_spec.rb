require './hangman.rb'

RSpec.describe Hangman, "#initialize" do
	before do
		@hangman = Hangman.new(8, "bottle")
	end

	context "with a correct arguments" do
		it "sets #word to an array of letters" do
			expect(@hangman.word).to eq(["b", "o", "t", "t", "l", "e"]) 
		end

		it "sets #lives_remaining to the correct number of lives" do
			expect(@hangman.lives_remaining).to eq 8
		end

		it "sets #guessed_letters to an empty array" do
			expect(@hangman.guessed_letters).to eq([])
		end

		it "sets #remaining_letters to an array of letters" do
			expect(@hangman.remaining_letters).to eq(["b", "o", "t", "t", "l", "e"])
		end

		it "sets #board to an array of underscores" do
			expect(@hangman.board).to eq(["_", "_", "_", "_", "_", "_"])
		end
	end

	context "with an incorrect guess" do
	end
	
end