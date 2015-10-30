require_relative '../lib/gameview.rb'

RSpec.describe GameView do
	let(:input) { double("input") }
	let(:output) { double("output") }
	subject(:state) { instance_double("GameState") }
	subject(:view) { GameView.new(input, output) }

	describe "#ask_for_letter" do
		context "given a single lowercase letter" do
			before do
				expect(input).to receive(:gets) { "b" }
			end

			it "returns the letter uppercase" do
				expect(view.ask_for_letter).to eq "B"
			end
		end

		context "given a single uppercase letter" do
			before do
				expect(input).to receive(:gets) { "B" }
			end

			it "returns the letter uppercase" do
				expect(view.ask_for_letter).to eq "B"
			end
		end

		context "given anything other than a single English letter" do
			before do
				expect(input).to receive(:gets).and_return("bb", " ", "1", "ÿ", ";P", "b")
			end

			it "should report invalid input" do
				expect(view).to receive(:report_invalid_input).exactly(5).times
				expect(view.ask_for_letter).to eq "B"
			end
		end
	end

	describe "#begin_game" do
		before do
			expect(output).to receive(:puts).with("Welcome to hangman. Guess a letter.")
			expect(state).to receive(:board).and_return(["_"])
		end

		it "should print the board" do
			expect(output).to receive(:puts).with("_")
			view.begin_game(state)
		end
	end
end