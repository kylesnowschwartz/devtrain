require_relative '../lib/hangman.rb'

RSpec.describe Hangman do
  let(:lives) { 8 }
  let(:word) { "bottle" }
  let(:state) { GameState.new(lives, word) }
  let(:view) { instance_double("GameView") }
  subject(:hangman) { Hangman.new(view, state) }

  describe "#initialize" do
    it "is initialized" do
      expect{ hangman }.to_not raise_error
    end
  end

  describe "#play" do
    let(:lives) { 3 }
    let(:word) { "abc" }

    before do
      expect(view).to receive(:welcome_player)
    end

    context "when too many wrong guesses are made" do
      before do
        expect(view).to receive(:ask_for_letter).and_return("Z").exactly(3).times
        expect(view).to receive(:report_incorrect_guess).exactly(3).times
        expect(view).to_not receive(:report_correct_guess)
      end

      it "it reports the game as lost" do
        expect(view).to receive(:report_game_lost)
        expect(view).to_not receive(:report_game_won)
        hangman.play
      end
    end

    context "when only correct guesses are made" do
      context "for the word 'ABC'" do
        before do
          expect(view).to receive(:ask_for_letter).exactly(3).times.and_return("A", "B", "C")
          expect(view).to receive(:report_correct_guess).exactly(3).times
          expect(view).to_not receive(:report_incorrect_guess)
        end

        it "it reports the game as won" do
          expect(view).to receive(:report_game_won)
          expect(view).to_not receive(:report_game_lost)
          hangman.play
        end
      end

      context "for the word 'AAA'" do
        let(:word) { "AAA" }

        before do
          expect(view).to receive(:ask_for_letter).exactly(1).times.and_return("A")
          expect(view).to receive(:report_correct_guess).exactly(1).times
          expect(view).to_not receive(:report_incorrect_guess)
        end

        it "it reports the game as won" do
          expect(view).to receive(:report_game_won)
          expect(view).to_not receive(:report_game_lost)
          hangman.play
        end
      end

      context "for the word 'abc'" do
        let(:word) { "abc" }

        before do
          expect(view).to receive(:ask_for_letter).exactly(3).times.and_return("A", "B", "C")
          expect(view).to receive(:report_correct_guess).exactly(3).times
          expect(view).to_not receive(:report_incorrect_guess)
        end

        it "it reports the game as won" do
          expect(view).to receive(:report_game_won)
          expect(view).to_not receive(:report_game_lost)
          hangman.play
        end
      end
    end
  end
end