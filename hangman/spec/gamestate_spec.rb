require './gamestate.rb'

RSpec.describe GameState do
	let(:game) { GameState.new(8, "bottle".upcase.chars)}
	let(:game_with_zero_lives) { GameState.new(0, "bottle".upcase.chars)}

	describe "#initialize" do
		it "sets #word to an array of uppercase letters" do
			expect(game.word).to eq(["B", "O", "T", "T", "L", "E"]) 
		end

		it "sets #lives_remaining to the correct number of lives" do
			expect(game.lives_remaining).to eq 8
		end

		it "sets #guessed_letters to an empty array" do
			expect(game.guessed_letters).to eq([])
		end

		it "sets #remaining_letters to an array of letters" do
			expect(game.remaining_letters).to eq(["B", "O", "T", "T", "L", "E"])
		end

		it "sets #board to an array of underscores" do
			expect(game.board).to eq(["_", "_", "_", "_", "_", "_"])
		end
	end

	describe "#subtract_life" do
		it "subtracts a life" do
			expect(game.subtract_life).to eq(7)
		end
	end

	describe "#finished?" do
		context "with lives remaining" do
			it "returns false" do
				expect(game.finished?).to be false
			end
		end

		context "if no lives remaining" do
			it "returns true" do
				expect(game_with_zero_lives.finished?).to be true
			end
		end
	end

	describe "#replace_blank_tile_with_guessed_letter" do
		context "with correct letter" do
			it "replaces a blank tile" do
				game.replace_blank_tile_with_guessed_letter("B")
				expect(game.board).to eq(["B", "_", "_", "_", "_", "_"])
			end
		end

		context "with incorrect letter" do
			it "does not replace a blank tile" do
				expect(game.board).to eq(["_", "_", "_", "_", "_", "_"])
			end
		end

		describe "#submit_guess" do
			context "correct guess" do
				it "returns true" do
					expect(game.submit_guess("B")).to be_truthy
				end
			end

			context "incorrect guess" do
				it "returns false" do
					expect(game.submit_guess("Q")).to be_falsey
				end
			end
		end
	end
end