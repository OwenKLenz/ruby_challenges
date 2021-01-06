# Write a program that, given a word and a list of possible anagrams, selects 
# the correct sublist that contains the anagrams of the word.

# For example, given the word "listen" and a list of candidates like "enlists" 
# "google" "inlets" "banana" the program should return a list containing 
# "inlets". Please read the test suite for exact rules of anagrams.

# Input: A string followed by an array of words that may or may not be anagrams 
# of the original string
# Output: An array of all words that ARE anagrams of the original string

# Data Structure: Array of anagrams and also array of letters (to iterate over)

# algorithm: Iterate over each letter in the original word, and  select the
# words that contain the same number of each of those letters (letters.all)
# compare the count of that letter with the count of that letter in each letter

class Anagram
  def initialize(word)
    @anagram_word = word
    # @word_permutations = word.downcase.chars.permutation.to_a.map(&:join)
    @sorted_letters = word.downcase.chars.sort
  end

  def match(word_array)
    word_array.select do |word|
      next if word.size != @anagram_word.size
      word.downcase.chars.all? do |letter| 
        word.downcase.count(letter) == @anagram_word.downcase.count(letter) &&
        word.downcase != @anagram_word.downcase
      end
    end
  end

  # def match(word_array)
  #   anagrams = word_array.select do |word| 
  #     @word_permutations.include?(word.downcase)
  #   end
  #   anagrams.delete_if { |word| word.match(/#{@anagram_word}/i)}
  # end

  # def match(word_array)
  #   word_array.select do |word| 
  #     word.downcase.chars.sort == @sorted_letters && 
  #     word.downcase != @anagram_word.downcase
  #   end
  # end
end
