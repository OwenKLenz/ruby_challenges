# Write a program that, given a number

# Can check if it is valid per the Luhn formula. This should treat, for example, 
# "2323 2005 7766 3554" as valid.
# Can return the checksum, or the remainder from using the Luhn method.
# Can add a check digit to make the number valid per the Luhn formula and return 
# the original number plus that digit. This should give "2323 2005 7766 3554" in 
# response to "2323 2005 7766 355".

# Input: An integer
# Output:
#   - The ADDENDS (array of the digits of input number after running them through 
#     the formula)
#   - Boolean determing whether or not number is VALID? (does checksum end in zero?)
#   - The CHECKSUM of the number, (after performing luhn's algorithm on number)
#   - Class method that converts an input number to a valid Luhns and returns it

# Data Structures:
#   Array - of digits (ADDENDS) after performing the formula
#   Integers

# Algorithm:
#   Finding addends:
#     convert to array of digits, iterate over digits with index(map?)
#     if index is even, return digit
#     elsif digit is > 4, subtract 1 from digit
#     else double digit

  # CREATE valid number: - class method
  #   return number if new Luhn object created with number is valid?
  #   append a zero to the array
  #   find the new checksum

  # 1111 becomes 2121, with 0 on end it becomes 11110 12120
  # get last digit of checksum
  # subtract it from 10
  # set last digit of digits array (0) to result % 10

class Luhn
  attr_reader :addends, :checksum

  def initialize(number)
    @number = number
    @addends = acquire_addends.reverse
    @checksum = sum_addends
  end

  def acquire_addends
    @number.digits.map.with_index do |digit, index|
      if index.even?
        digit
      else
        digit > 4 ? digit * 2 - 9 : digit * 2
      end
    end
  end

  def sum_addends
    addends.inject(:+)
  end

  def valid?
    checksum % 10 == 0
  end

  def self.create(number)
    return number if Luhn.new(number).valid?

    check_digit = find_needed_check_digit(number)
    (number.to_s + check_digit.to_s).to_i
  end

  private

  def self.find_needed_check_digit(number)
    (10 - Luhn.new(number * 10).checksum.digits.first) % 10
  end
end

p Luhn.new(12121).addends
p Luhn.new(8631).addends
p Luhn.new(1111).checksum
p Luhn.new(8763).checksum
p Luhn.create(873956)
p Luhn.create(8_372_637_564)

# Input: String
# Output: Boolean

# iterate over the string from left to right and from left to righ (simultaneously)
# if character is a letter upper or lowercase
#   append it to forward
# compare the strings

def palindrome?(string)
  forward = ''
  backward = ''
  string.length.times do |ind|
    forward += string[ind] if ('a'..'z').include?(string[ind].downcase)
    backward += string[-(ind + 1)] if ('a'..'z').include?(string[-(ind + 1)].downcase)
  end
  forward == backward
end

p palindrome?("no1, 3on") == true
p palindrome?("madam i'm adam") == true
p palindrome?("abcba") == true
p palindrome?('asdfjkfe') == false
p palindrome?('7867') == false