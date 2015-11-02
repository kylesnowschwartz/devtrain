require_relative './hangman.rb'

lives = 8
word = "bottle"
state = GameState.new(lives, word)
view = GameView.new(STDIN, STDOUT, state)
hangman = Hangman.new(view, state)

hangman.play