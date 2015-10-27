require './hangman.rb'

RSpec.describe Hangman do
	before do
		@hangman = Hangman.new(8, "bottle")
	end

	describe "#initialize" do

		context "with a correct arguments" do
			it "sets #word to an array of uppercase letters" do
				expect(@hangman.word).to eq(["B", "O", "T", "T", "L", "E"]) 
			end

			it "sets #lives_remaining to the correct number of lives" do
				expect(@hangman.lives_remaining).to eq 8
			end

			it "sets #guessed_letters to an empty array" do
				expect(@hangman.guessed_letters).to eq([])
			end

			it "sets #remaining_letters to an array of letters" do
				expect(@hangman.remaining_letters).to eq(["B", "O", "T", "T", "L", "E"])
			end

			it "sets #board to an array of underscores" do
				expect(@hangman.board).to eq(["_", "_", "_", "_", "_", "_"])
			end
		end

		context "with an incorrect arguments" do

			it "raises an error when given 0 lives" do
				expect {Hangman.new(0, "bottle")}.to raise_error("The number of lives must be greater than zero")
			end

			it "raises an error when given a word less than 3 letters long" do
				expect {Hangman.new(3, "at")}.to raise_error("The word must have 3 or more letters")
			end
		end
	end

	describe "#play" do
		it "takes turns equal to at least the amount of letters of the word" do			
			
		end		

		it "takes turns equal to at least the amount of letters of the word" do			
			game = instance_double("Hangman", :word => ["B", "O", "T", "T", "L", "E"],
																		:remaining_letters => ["B", "O", "T", "T", "L", "E"],
																		:guessed_letters => [],
																		:lives_remaining => 8,
																		:board => ["_", "_", "_", "_", "_", "_"]
														)
			allow(game).to receive(:ask_for_letter).and_return("B", "O", "T", "T", "L", "E")
			allow(game).to receive(:submit_guess).with(:ask_for_letter).and_return(true)
			allow(game).to receive(:play)
			expect(game).to receive(:take_turn).at_least(5).times
		end
	end
end