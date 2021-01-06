# Write a program that given a phrase can count the occurrences of each word in 
# that phrase.

# For example, if we count the words for the input "olly olly in come free", we 
# should get:

# olly: 2
# in: 1
# come: 1
# free: 1

# Input: a phrase consisting of some words
# Output: a hash of words as keys and count of those words as values

# Considerations:
#   Word: one or more alpha numeric characters in a row, delimited by any non 
#   alpha numeric characters

#   Downcase the phrase at the start, as the hash keys should be downcased

#   parentheses are part of a word
#     IOW: parentheses at the start/end of a word are quotes, parentheses with
#     characters on either side are parentheses and part of the word

# Date Structures:
#   Hash to store words as keys and number counts of each word
#   Phrase starts a a String
#   Split phrase into a word

# Algorithm:
#   Downcase the phrase
#   Try String#scan with a regex to get an array of all the "words" as defined above
#   then iterate over the scanned array and increment the value associated with that
#   word key in a hash with a default value of 0.

class Phrase
  def initialize(phrase)
    @phrase = phrase.downcase
  end

  # def word_count
  #   words = get_words
  #   word_count_hash = Hash.new(0)
  #   words.each { |word| word_count_hash[word] += 1 }
  #   word_count_hash
  # end

  # def get_words
  #   @phrase.scan(/\b[\w']+\b/)
  # end

  def word_count # Short version

    @phrase.scan(/\b[\w']+\b/).each_with_object(Hash.new(0)) do |word, hash|
      hash[word] += 1
    end
  end   

  # def word_count
  #   init word_start_counter to 0
  #   init word_end_counter to 0
  #   init words array
  #   iterate until word_start_counter references a letter character
  #     return words array if phrase[counter] = nil
  #     set word_end_counter to word_start_counter
  #     increment word end counter
  #     if phrase[word_end_counter] is a non-word character
  #       if the current character is a ' and the following character is a letter
  #         keep iterating, otherwise  append phrase [word start .. word end] to words array
  # end
end
 