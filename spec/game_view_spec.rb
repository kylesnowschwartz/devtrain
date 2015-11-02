require_relative '../lib/game_view.rb'

RSpec.describe GameView do
	let(:input) { double("input") }
	let(:output) { double("output") }
	let(:state) { instance_double("GameState") }
	let(:view) { GameView.new(input, output, state) }

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

	describe "#welcome_player" do
		before do
			expect(output).to receive(:puts).with("Welcome to hangman. Guess a letter.")
			expect(state).to receive(:board).and_return(["_"])
		end

		it "should print the board" do
			expect(output).to receive(:puts).with("_")
			view.welcome_player
		end
	end

	describe "#report_correct_guess" do
		let(:state) do
			instance_double(
				GameState,
				guessed_letters: ["A"],
				letters_remaining: ["B"],
				lives_remaining: 1,
				board: ["_"]
			)
		end

		context "game is not finished" do

			before do
				expect(state).to receive(:finished?).and_return(false)
			end

			it "should print the board" do
				expect(output).to receive(:puts).with("You guessed correctly!")
				standard_report_message
				expect(output).to receive(:puts).with("Guess Again:")
				view.report_correct_guess
			end
		end

		context "game is finished" do

			before do
				expect(state).to receive(:finished?).and_return(true)
			end

			it "should print the board" do
				expect(output).to receive(:puts).with("You guessed correctly!")
				standard_report_message
				view.report_correct_guess
			end
		end
	end

	describe "#report_incorrect_guess" do
		let(:state) do
			instance_double(
				GameState,
				guessed_letters: ["A"],
				letters_remaining: ["B"],
				lives_remaining: 1,
				board: ["_"]
			)
		end
		
		context "game is not finished" do

			before do
				expect(state).to receive(:finished?).and_return(false)
			end

			it "should print the board" do
				expect(output).to receive(:puts).with("Sorry, you guessed incorrectly")
				standard_report_message
				expect(output).to receive(:puts).with("Guess Again:")
				view.report_incorrect_guess
			end
		end


		context "game is finished" do

			before do
				expect(state).to receive(:finished?).and_return(true)
			end

			it "should print the board" do
				expect(output).to receive(:puts).with("Sorry, you guessed incorrectly")
				standard_report_message
				view.report_incorrect_guess
			end
		end
	end

	def standard_report_message
		expect(output).to receive(:puts).with("Thusfar, you've guessed:")
		expect(output).to receive(:puts).with("A")
		expect(output).to receive(:puts).with("You have 1 letters remaining")
		expect(output).to receive(:puts).with("You have 1 lives remaining")
		expect(output).to receive(:puts).with("_")
	end
end