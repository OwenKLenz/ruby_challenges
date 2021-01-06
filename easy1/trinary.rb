# Write a program that will convert a trinary number, represented as a string 
# (e.g. '102012'), to its decimal equivalent using first principles (without 
# using an existing method or library that can work with numeral systems).

# Trinary numbers can only contain three symbols: 0, 1, and 2. Invalid trinary 
# entries should convert to decimal number 0.

# The last place in a trinary number is the 1's place. The second to last is 
# the 3's place, the third to last is the 9's place, etc.

# # "102012"
#     1       0       2       0       1       2    # the number
# 1*3^5 + 0*3^4 + 2*3^3 + 0*3^2 + 1*3^1 + 2*3^0    # the value
#   243 +     0 +    54 +     0 +     3 +     2 =  302

# input: A string (can be letters or non-trinary digits)
# output: An integer (The decimal equivalent of the trinary argument)

# Data Structures:
# string as argument
# Array

# Considerations:
# If arg contains any non numberic characters, return 0
# If arg contains any digits from 3-9, return 0

# Algo:
#   Validation method sets @trinary_digits attribute to 0 if invalid or array of
#   otherwise
  
#   Conversion:
#     Iterate across the digits
#     rightmost digit gets multiplied by 3 ^ 0
#     2nd to right digit gets multiplied by 3 ^ 1
#     3rd to right digits gets multiplied by 3 ^ 2, etc.
#     Maybe reverse the array so we can work with index

#     1021 == 1 * 3 ^ 0 + 2 * 3 ^ 1 + 0 * 3 ^ 2 + 1 * 3 ^ 3
#                 1   +       6      +    0      +    9  = 16
require 'pry'
class Trinary
  def initialize(str)
    @trinary_digits = convert_to_array_of_trinary_digits(str)
  end

  def to_decimal
    return @trinary_digits if @trinary_digits == 0

    decimal = 0
    @trinary_digits.each_with_index do |digit, index|
      decimal += digit * 3 ** index
    end
    decimal
  end

  private

  def convert_to_array_of_trinary_digits(str)
    return 0 unless valid_trinary?(str)
    str.to_i.digits
  end

  def valid_trinary?(str)
    str.match?(/\A[0-2]+\z/)
  end
end

class Trinary
  def initialize(str)
    @trinary_num = str
  end

  def to_decimal
    return 0 unless valid_trinary?

    decimal = 0
    @trinary_num.to_i.digits.each_with_index do |digit, index|
      decimal += digit * 3 ** index
    end
    decimal
  end

  private

  def valid_trinary?
    @trinary_num.match?(/\A[0-2]+\z/)
  end
end

class BaseX
  HEX_VALUES = (("0".."9").to_a + ('a'..'f').to_a).zip(0..15).to_h.freeze

  def initialize(num_str, base)
    @base_x_num = num_str.downcase
    @base = base.to_i
    @valid_digits = /\A[0-9a-f]+\z/
  end

  def to_decimal
    return 0 unless valid_base_x_num?

    str_to_nums.reverse.each_with_index.inject(0) do |accum, (digit, index)|
      accum + digit * @base ** index
    end
  end

  private

  def str_to_nums
    @base_x_num.chars.map { |char| char =~ /\d/ ? char.to_i : HEX_VALUES[char] }
  end

  def valid_base_x_num?
    @base_x_num.match?(@valid_digits)
  end
end

loop do
  puts "Enter a number of any base (0 to exit)"
  num_str = gets.chomp
  break if num_str == '0'
  puts "Enter the base of the number"
  base = gets.chomp
  if base.match?(/[^0-9a-f]/) || num_str.match?(/[^0-9a-f]/)
    puts "Invalid base or number"
    next
  end
  puts "#{num_str} in base #{base} is #{BaseX.new(num_str, base).to_decimal} in decimal"
end