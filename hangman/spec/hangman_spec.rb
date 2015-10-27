require './hangman.rb'

RSpec.describe Hangman do
	let(:hangman) {Hangman.new(8, "bottle")}

	describe "#initialize" do

		context "with a correct arguments" do
			it "sets #word to an array of uppercase letters" do
				expect(hangman.word).to eq(["B", "O", "T", "T", "L", "E"]) 
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
		before do
			def 
		end
		it "takes at least n turns equal to the amount of uniq letters in word" do
			hangman.play
		end
	end
end