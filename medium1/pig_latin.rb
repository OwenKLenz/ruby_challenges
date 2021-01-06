# Input: A string (one or more words)
# Output: A pig latinified string

# Data Structure:
#   String for the input and Output
#   split string input into array of words
#   Some sort of lookup table(s) for the different word beginnings and endings

# Considerations:
#   LOTS of edge cases!
#   Some words chop of first letter and move it to end + 'ay'
#   Some chop off several letters and move to end with 'ay'
#   Some simply add 'ay'
#   What to do with empty string? (Shouldn't matter if string is converted to 
#     array of words)
  # What about words BEGINNINGSing with 'xy' xylophone? 'ylophonexay'

# Algorithm:
#   If word BEGINNINGSs with vowel or 'y' or 'x' followed by a consenant, simply append 'ay'
#   If word BEGINNINGSs with a 1 or more consecutive consenants, move them to the end and
#     append 'ay'
#   If word BEGINNINGSs with 'qu' or 1 consenant + 'qu', move all that business to end
#     and append 'ay'

# Regexes
#     If index returned for pattern is zero, sub match to the end of the string
#   /[a-z&&[^aeiou]]?qu/ - for 'qu' words with or without BEGINNINGSing consenant
#     - remove match and append to end with 'ay'

#   /([aeiou]|(x|y)[a-z&&[^aeiou]])/ - Matches vowel words/x or y followed by 
#     consenant - simply append 'ay'

#   /[a-z&&[^aeiou]]+/ - use capture group to track the consecutive consenants? 
#     Or just get the indexes? (better with cons. + 'h'?)
#     - append capture group + 'ay' to end


# "asdjfkd"
# suffix  = str[0..1] + 'ay'
# str = str[2..-1] + 'suffix'

class PigLatin
  BEGINS_WITH_CONSONANT = /\A([a-z&&[^aeiou]]?qu)|([a-z&&[^aeiou]]+)/i
  BEGINS_WITH_VOWEL_OR_X_Y_CONS = /\A([aeiou]|(x|y)[a-z&&[^aeiou]])/i

  def self.translate(string)
    string.split.map(&method(:pig_latinify)).join(' ')
  end

  def self.pig_latinify(word)
    if word =~ BEGINS_WITH_VOWEL_OR_X_Y_CONS
      word + 'ay'
    elsif word =~ BEGINS_WITH_CONSONANT
      split_word = word.partition(BEGINS_WITH_CONSONANT)
      split_word[2] + split_word[1] + 'ay'
    end
  end
end

p PigLatin.translate("quelch")
p PigLatin.translate("ear")
p PigLatin.translate('tear')
p PigLatin.translate('quick fast run')
p PigLatin.translate('fletch')
p PigLatin.translate('xylophone')
p PigLatin.translate('bntquine')

i  = 20
while i > 10 do
  puts i
  i -= 1
end