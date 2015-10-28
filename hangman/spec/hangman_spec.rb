require_relative "../lib/hangman"

RSpec.describe Hangman do
	let(:word) { "bread" }
	let(:lives) { 4 }
	subject(:hangman) { Hangman.new(lives, word, input, output) }
	let(:output) { StringIO.new }

	def random_valid_word
		rand(4..6).times.map { ('a'..'z').to_a.sample }.join
	end

	context "without any input" do
		let(:lives) { rand(10) }
		let(:word) { random_valid_word }
		let(:input) { StringIO.new }
		it "should welcome the user, invite a guess and just exit" do
			hangman
			expect(output.string).to eq("")
			hangman.play
			dashes = word.size.times.map { "_" }.join(" ")
			expect(output.string).to eq(<<EOF)
Welcome to hangman.
#{lives} lives remaining.
#{dashes}
Please enter a letter:
EOF
		end
	end

	context "with only wrong guesses" do
		let(:lives) { 1 }
		let(:word) { "a" }
		let(:input) { StringIO.new("z\n") }
		it "should report the game as lost" do
			hangman.play
			expect(output.string).to eq(<<EOF)
Welcome to hangman.
1 lives remaining.
_
Please enter a letter:
Sorry, you lost. The word was "a".
EOF
		end
	end

	context "with a correct guess" do
		let(:lives) { 1 }
		let(:word) { "aa" }
		let(:input) { StringIO.new("a\n") }
		it "should report the game as won" do
			hangman.play
			expect(output.string).to eq(<<EOF)
Welcome to hangman.
1 lives remaining.
_ _
Please enter a letter:
You won: the word was "aa".
EOF
		end
	end

	context "with two correct guesses" do
		let(:lives) { 1 }
		let(:word) { "ab" }
		let(:input) { StringIO.new("b\na\n") }
		it "should report the game as won" do
			hangman.play
			expect(output.string).to eq(<<EOF)
Welcome to hangman.
1 lives remaining.
_ _
Please enter a letter:
1 lives remaining.
_ b
Please enter a letter:
You won: the word was "ab".
EOF
		end
	end

end