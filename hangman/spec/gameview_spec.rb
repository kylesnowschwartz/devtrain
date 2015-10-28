require "./gameview.rb"

RSpec.describe GameView do
	subject(:view) { GameView.new }
	let(:input) { double("input") }

	describe "#ask_for_letter" do
		context "given a single lowercase letter" do
			before do
				expect(input).to receive(:gets) { "b" }
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

		context "given more than 1 letter" do
			before do
				expect(view).to receive(:gets).and_return("bb", "b")
			end

			it "should say 'Please select a single letter in the English alphabet:' when run" do
				expect(view).to receive(:puts).with("Please select a single letter in the English alphabet:")
				expect(view.ask_for_letter).to eq "B"
			end
		end
	end
end