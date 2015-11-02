class GameState
  attr_reader :lives_remaining, :guessed_letters, :board

  def initialize(lives, word)
    raise ArgumentError, "The word must have 3 or more letters" unless word.length >= 3
    raise ArgumentError, "The number of lives must be greater than zero" unless lives > 0

    @letters = break_word_into_letters(word)
    @guessed_letters = []
    @lives = lives
  end

  def finished?
    zero_lives_remaining? || letters_remaining.empty?
  end

  def submit_guess(guess)
    @guessed_letters << guess
    @letters.include?(guess)
  end

  def zero_lives_remaining?
    lives_remaining == 0
  end

  def lives_remaining
    @lives - (@guessed_letters - @letters).count
  end

  def letters_remaining
    @letters - @guessed_letters
  end

  def board
    tiles = @letters.map { "_" }

    @guessed_letters.each do |letter|
      all_indexes_for_letter(letter).each do |index|
        @letters.include?(letter) ? tiles[index] = letter : "_"
      end
    end

    tiles
  end

  private

  def all_indexes_for_letter(letter)
    @letters.each_index.select { |index| @letters[index] == letter } # returns all indicies of given letter if there are duplicates, not just the first index
  end

  def break_word_into_letters(word)
    word.upcase.chars
  end
end