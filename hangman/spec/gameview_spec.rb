require "./gameview.rb"

RSpec.describe GameView do
	subject(:view) { GameView.new }

	describe "#ask_for_letter" do
		context "given a single lowercase letter" do
			before do
				expect(view).to receive(:gets) { "b" }
			end

			it "returns the letter" do
				expect(view.ask_for_letter).to eq("B")
			end
		end

		context "given a single uppercase letter" do
			before do
				expect(view).to receive(:gets) { "B" }
			end

			it "returns the letter" do
				expect(view.ask_for_letter).to eq("B")
			end
		end

		xcontext "given more than 1 letter" do
			before do
				expect(view).to receive(:ask_for_letter)
				expect(view).to receive(:gets) { "bb" }
			end

			it "should say 'Please select a single letter in the English alphabet:' when run" do
				expect(STDOUT).to receive(:puts).with("Please select a single letter in the English alphabet:").at_least(:once)
			end
		end
	end
end