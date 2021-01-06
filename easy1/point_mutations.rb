# By counting the number of differences between two homologous DNA strands 
# taken from different genomes with a common ancestor, we get a measure of 
# the minimum number of point mutations that could have occurred on the 
# evolutionary path between the two strands.

# This is called the 'Hamming distance'

# GAGCCTACTAACGGGAT
# CATCGTAATGACGGCCT
# ^ ^ ^  ^ ^    ^^
# The Hamming distance between these two DNA strands is 7.

# The Hamming distance is only defined for sequences of equal length. If you 
# have two sequences of unequal length, you should compute the Hamming distance
#  over the shorter length.

# Input: Two DNA strands of potentially differing lengths (strings of uppercase 
# letters)
# Output: An integer indicating the number of point mutations (non-matching 
# letters across the two strings)

# Considerations:
#   - If strands are of unequal length, use the length of the shorter strand
#   - 0 should be returned if any strand is empty

# Data Structures:
#   Strings that can be iterated over by index

# Algorithm:
#   - Determine the index of the string that we want to iterate up to while 
#   comparing letters
#     - end_of_strand is set to the smaller of the two sizes of strings
#   - Iterate from 0 up to but not including end of strand (as an index value)
#   - Maybe use inject, to have an accumulator to track the non-matching pairs

class DNA
  def initialize(dna_strand)
    @dna_strand = dna_strand
  end

  # def hamming_distance(other_strand)
  #   end_of_strand = [@dna_strand.size, other_strand.size].min

  #   (0...end_of_strand).inject(0) do |mutations, index|
  #     mutations + (@dna_strand[index] == other_strand[index] ? 0 : 1)
  #   end
  # end

  def hamming_distance(other_strand)
    zipped_strands = combine_and_even_strands(other_strand)
    zipped_strands.count { |base_one, base_two| base_one != base_two }
  end

  private

  def combine_and_even_strands(other_strand)
    @dna_strand.chars.zip(other_strand.chars).delete_if do |pair| 
      pair.include?(nil)
    end
  end
end

# zip arrays of characters together
# count the number of elements where each element where the pairs are unequal

def gcd(a, b)
  counter = 1
  starting_point = [a, b].min
  loop do
    divider = starting_point / counter
    return divider if a % divider == 0 && b % divider == 0
    counter += 1
  end
end

p gcd(9, 15)
p gcd(100, 11)
p gcd(14, 28)