# Input: An Integer
# Output: A string equal to that integer converted to a roman numeral

# Data Structures:
#   Ordered list (array) of roman numerals in order from smallest to largest
#   %w(I V X L C D M) or maybe hash is better (mapped to the appropriate integer value)
#   String to return the roman numeral

# Algorithm:
#   Iterate across roman numeral hash from largest to smallest
#   if calling integer minus current numeral value is greater than , subtract that
#     value and add the key to the return string
#   if current integer value (after subtracting) is 0, return the string
    # Simple Case: No subtraction
    #   Iterate over numerals from greatest to smallest
    #   if number - current numeral is greater than 0, subtract numeral value and
    #     concat numeral to return string

class Integer
  def to_roman
    numeral_hash = { 'M' => [7, 1000], 'D' => [6, 500], 
                    'C' => [5, 100], 'L' => [4, 50], 
                    'X' => [3, 10], 'V' => [2, 5], 
                    'I' => [1, 1] }
    integer = self
    numeral_string = ''
    while integer > 0
      numeral_hash.each do |numeral, (_, value)| 
        if integer - value >= 0
          numeral_string << numeral
          integer -= value
          break
        end
      end
    end
    fix(numeral_string, numeral_hash)
  end

  def fix(numeral_string, numeral_hash)
    numerals = %w(I V X L C D M)
    p numeral_string
    while numeral_string =~ /(.)\1{3}/
      prob_index = numeral_string =~ /(.)\1{3}/
      if prob_index == 0
        numeral_string[prob_index..prob_index + 3] = numeral_string[prob_index] + numerals[numerals.index(numeral_string[prob_index]) + 1]
      elsif numeral_hash[numeral_string[prob_index - 1]][0] - numeral_hash[numeral_string[prob_index]][0] == 2
        numeral_string[prob_index..prob_index + 3] = numeral_string[prob_index] + numerals[numerals.index(numeral_string[prob_index]) + 1]
      else
        numeral_string[(prob_index - 1)..prob_index + 3] = numeral_string[prob_index] + numerals[numerals.index(numeral_string[prob_index]) + 2]
      end
    end
    numeral_string
  end
end


# if there are 4 of a numeral (regex to match)
#   if the preceding numeral is 2 places greater (CXXXX)
#     replace the 4 numerals with the next greatest numeral, preceded by the 4 numeral
#   if the preceding numeral is 1 place greater
#     replace the 4 numerals AND the preceding numeral with a the numeral 2 places greater
#     than the 4 numeral preceded by the 4 numeral


# convert int to digits
# digits.size.times
#   if current digit is 3 or less
#     subtract current digit times the decimal place value (3 in the hundreds place, subtract 3 * 100)
#     Add current digit * current numeral to numeral string
#   if digit is 5, append appropriate 5 digit

#   if current digit is 4, 