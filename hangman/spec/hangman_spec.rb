require './hangman.rb'

RSpec.describe Hangman do
	let(:lives) { 8 }
	let(:word) { "bottle" }
	let(:state) { GameState.new(lives, word) } #instance double here?
	# let(:state) { instance_double("GameState", :finished? => true, :lives_remaining => 0) }
	let(:view) { instance_double("GameView") }
	let(:hangman) { Hangman.new(view, state) } # check out subject instead of let

	describe "#initialize" do
		it "is initialized" do
			expect{ hangman }.to_not raise_error
		end
	end

	describe "#play" do
		let(:lives) { 3 }
		let(:word) { "abc" }

		before do
			expect(view).to receive(:begin_game)	
		end

		context "when too many wrong guesses are made" do
			before do
				expect(view).to receive(:ask_for_letter).and_return("Z").exactly(3).times
				expect(view).to receive(:report_incorrect_guess).exactly(3).times
			end

			it "it reports the game as lost" do
				expect(view).to receive(:report_game_lost)
				hangman.play
			end
		end

		context "when correct guesses are made" do
			before do
				expect(view).to receive(:ask_for_letter).exactly(3).times.and_return("A", "B", "C")
				expect(view).to receive(:report_correct_guess).exactly(3).times
			end

			it "it reports the game as won" do
				expect(view).to receive(:report_game_won)
				hangman.play
			end
		end
	end
end