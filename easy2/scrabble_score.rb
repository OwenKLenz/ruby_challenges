# Write a program that, given a word, computes the scrabble score for that word.

# Input: Any value (could be nil, whitespace, etc.) should return 0 for invalid inputs
# Output: An integer score for the input

# Data Structure:
#   - A hash of point keys with letter values
#   - A String input
#   - An integer sum output

# Considerations:
#   - If input contains non-letter characters, return 0
#   - Case insensitive

# Algorithm:
#   - regex to match non-letter chars, if true, return zero


#   Create a hash
#     - {1 => [a e i o], 2 => d, g etc.}
#     - init score to 0
#   Upcase input String
#   For each letter in input String
#     - Iterate over hash, if key contains the current letter, increment score and next

#   return score

class Scrabble
  SCORE_HASH = { 
                 1 => %w(A E I O U L N R S T),
                 2 => %w(D G),
                 3 => %w(B C M P),
                 4 => %w(F H V W Y),
                 5 => %w(K),
                 8 => %w(J X),
                10 => %w(Q Z)
               }

  def initialize(string)
    @scrabble_word = string
  end

  def self.score(str)
    Scrabble.new(str).score
  end

  def score
    return 0 if @scrabble_word.nil? || @scrabble_word.match?(/[^A-Z]/i)
    @scrabble_word.upcase.chars.inject(0) do |score, letter| 
      SCORE_HASH.each do |points, letters|
        if letters.include?(letter)
          score += points
          break
        end
      end
      score
    end
  end
end
 