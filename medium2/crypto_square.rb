# Implement the classic method for composing secret messages called a square 
# code.

# The input is first normalized: The spaces and punctuation are removed from the 
# English text and the message is down-cased.

# Then, the normalized characters are broken into rows. These rows can be 
# regarded as forming a rectangle when printed with intervening newlines.

# For example, the sentence

# If man was meant to stay on the ground god would have given us roots

# is 54 characters long.

# Broken into 8-character columns, it yields 7 rows.

# Those 7 rows produce this rectangle when printed one per line:

# ifmanwas
# meanttos
# tayonthe
# groundgo
# dwouldha
# vegivenu
# sroots
# The coded message is obtained by reading down the columns going left to right.
# For example, the message above is coded as:

# imtgdvs fearwer mayoogo anouuio ntnnlvt wttddes aohghn sseoau
# Write a program that, given an English text, outputs the encoded version of
# that text.

# The size of the square (number of columns) should be decided by the length of
# the message. If the message is a length that creates a perfect square
# (e.g. 4, 9, 16, 25, 36, etc), use that number of columns. If the message
# doesn't fit neatly into a square, choose the number of columns that
# corresponds to the smallest square that is larger than the number of
# characters in the message.

# For example, a message 4 characters long should use a 2 x 2 square. A message
# that is 81 characters long would use a square that is 9 columns wide. A
# message between 5 and 8 characters long should use a rectangle 3 characters
# wide.

# Output the encoded text grouped by column.

# Input: A string of words
# Output:
#   normalize_plaintext:
#     input string with punctuation and whitespace removed and message downcased
#   size:
#     An integer (the size of the lowest square root, the square of which is
#     larger than or equal to the number of characters).
#   plaintext_segments:
#     Array of text segments broken up into equal length rows
#   ciphertext:
#     The "columns" of plaintext segments concatented together
#   normalize_ciphertext:
#     An array of text segments each of which is a column from the rows of plaintext (translation?)

# Data Structures:
#   Strings
#   Arrays

# Considerations:
#   Strings with fewer than n ^ 2 characters will result in missing rows/last 
#     row's length less than row_length
#   Empty string?

class Crypto
  attr_reader :normalized_plaintext
  alias_method :normalize_plaintext, :normalized_plaintext

  def initialize(string)
    @normalized_plaintext = string.gsub(/[^[:alnum:]]/, "").downcase
  end

  def size(size_val=0)
    size_val ** 2 >= normalize_plaintext.length ? size_val : size(size_val + 1)
  end

  def plaintext_segments
    normalize_plaintext.scan(/.{1,#{size}}/)
  end

  def ciphertext
    normalize_ciphertext.delete(' ')
  end

  def normalize_ciphertext
    char_subarrays = plaintext_segments.map { |line| line.split('') }
    last_subarray_padding = [nil] * (size - char_subarrays[-1].length) 

    char_subarrays[-1] += last_subarray_padding
    char_subarrays.transpose.map(&:join).join(' ')
  end
end

p Crypto.new('12345').size
p Crypto.new('123456789').size
p Crypto.new('12345678123129').size

p Crypto.new('123456789').plaintext_segments
p Crypto.new('12345678123129').plaintext_segments

p Crypto.new('1234567890').normalize_ciphertext #== "147 258 369"