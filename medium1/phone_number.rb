# Input: a phone number (1 or more characters)
# Outputs: 
#   to_s
#     A sexy phone number (802) 454-1904
#   area_code
#     First 3 digits of phone number (with a preceding '1' dropped if necessary)
#   number
#     The number with the preceding one dropped if necessary

# Data Structure:
#   A string

# Considerations:
#   Return '000000000000' if:
#     Number contains letters
#     Number length less than 10
#     Number length greater than 11
#     Number length 11 but doesn't start with a 1


# Algorithm:
#   If number contains letters, set number to 00000000...
#   Extract all non numeric characters
#   If resulting string size is greater than 11, set number to 00000 self = self.class.new(0000)?
#   if resulting string size is less than 10, set number to 00000
#   if resulting string size is 11 and doesn't start with 1, set to 00000
#   if number is 11 chars trim the one and use number
#   if number is 10 chars, use the number

class PhoneNumber
  INVALID_NUM = '0000000000'

  attr_accessor :number

  def initialize(string)
    @number = sanitize(string)
  end

  def area_code
    number[0..2]
  end

  def to_s
    "(#{area_code}) #{number[3..5]}-#{number[6..9]}"
  end

  private

  def sanitize(string)
    string.delete!("^0-9a-zA-Z")
    string.delete_prefix!('1') if string.size == 11
    string =~ /[:alpha:]/ || string.size != 10 ? INVALID_NUM : string
  end
end

p PhoneNumber.new('a').number
p PhoneNumber.new('1').number
p PhoneNumber.new('!123?> 456+_+_7890').number