# - A string consisting of letters, spaces and one period.
#   - Words consist of 1-20 characters
#   - String will be one or more words separated by one or more spaces
#   - String will end with 0+ spaces followed by a single point
#   - Input should be considered from first letter or first word to and including 
#     the terminatinng period
#   Gist:
#     Remove all extra spaces and end last word with a period
#     Odd index words (0 >1< 2 >3< etc...) are reversed

# Input: A string of words separated by 1 or more spaces ending with a . preceded by 0 or more spaces.
# Output: A string of words separated by a single space ending with a .

# Considerations:
#   - Empty string?
#   - Watch out for spaces between last word and period.

# Challenge: Read and print characters one at a time

# Algorithm:
  # find the index of the first non_space character (start of first word)
  # find the index of the last letter (reverse and search for alpha char)
  # init space_seen to false
  # iterate across word by index (from start index to index of last letter)
  # if character is a letter, print it
  #   if space_seen, space_seen = false
  # if character is space
  #   if space_seen is false, print space and set space_seen to true

  # print a . at the end

  # Reversing words:
  #   init reverse to false
  #   stop_index = first index with character followed by whitespace
  #   start_index = string[stop_index..end] =~ next non-whitespace character
    
  #   if reverse is true, iterate from stop_index to start_index, otherwise go forwards

def amend_string(string)
  return string if string.empty?
  start_index = string =~ /[a-zA-Z]/
  stop_index = string =~ /[a-zA-Z]( |\.)/
  finish_index = string.length - 1 - (string.reverse =~ /[a-zA-Z]/)

  reverse = false

  loop do
    (reverse ? ((start_index..stop_index).to_a.reverse) : (start_index..stop_index)).each do |index|
      print string[index]
    end
    break if stop_index >= finish_index
    print ' '
    reverse = !reverse

    start_index = stop_index + 1 + (string[(stop_index + 1)...string.size] =~ /[a-zA-Z]/)
    stop_index = start_index + (string[start_index ...string.size] =~ /[a-zA-Z]( |\.)/)
  end
  puts '.'
end

def amend_string(string)
  return string if string.empty?
  words = string.scan(/\b[a-zA-Z]+\b/).map.with_index do |word, index| 
    index.odd? ? word.reverse : word
  end
  words.join(' ') + '.'
end

# Test Cases:
p amend_string("whats the matter with kansas.") == "whats eht matter htiw kansas."
p amend_string("Hi     there  I  AM a cookie   .") == "Hi ereht I MA a eikooc."
p amend_string("hello.") == "hello."
p amend_string("    hi there .") == "hi ereht."
p amend_string("") == ""
p amend_string('  .')