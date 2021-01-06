# Write a program that will take a decimal number, and convert it to the 
# appropriate sequence of events for a secret handshake.

# There are 10 types of people in the world: Those who understand binary, and 
# those who don't. You and your fellow cohort of those in the "know" when it 
# comes to binary decide to come up with a secret "handshake".

# 1 = wink
# 10 = double blink
# 100 = close your eyes
# 1000 = jump
# 10000 = Reverse the order of the operations in the secret handshake.

# handshake = SecretHandshake.new 9
# handshake.commands # => ["wink","jump"]

# handshake = SecretHandshake.new "11001"
# handshake.commands # => ["jump","wink"]

# The program should consider strings specifying an invalid binary as the value 0.

# Input: A string of binary OR a decimal integer (to be converted to binary string)
# Output: An array of "commands"

# Data Structures:
#   - An array of commands with indexes matching the location of the digits 
#   associated with each command
#   - String, also referenced by index
#   - Return array

# Considerations:
#   - Should handle integers: Convert them to strings of binary
#   - if the resulting string contains any characters that are not 0 or 1, set string
#   to 0
#   - Reversing: Maybe have an boolean attribute set if string[4] == '1'

# Algorithm:
#   Determine bin_num method:
#     if argument is an integer, return arg.to_s(2)
#     if argument contains non 0 or 1 characters, return '0'
#     else return argument
    # Commands method:
    #   map with index on (0...(string.size > 4 ? 4 : string.size)
    #     if current_el == '1'
    #       append commands array on index to the return array
    #   compact mapped array at end

    #   if @reverse is true, reverse and return array
    #   otherwise return array

class SecretHandshake
  COMMANDS = ['wink', 'double blink', 'close your eyes', 'jump'].freeze

  def initialize(number)
    @bin_num = determine_binary_value(number).reverse
    @reverse = @bin_num[4] == '1'
  end

  def commands
    commands = []
    @bin_num[0...4].each_char.with_index do |char, index|
      commands << COMMANDS[index] if char == '1'
    end
    @reverse ? commands.reverse : commands
  end

  private

  def determine_binary_value(number)
    if number.class == Integer
    number.to_s(2)
    elsif number.to_s =~ /[^01]/
      '0'
    else
      number
    end
  end
end

class ZeroIndex
  def self.process_commands(commands)
    commands << "wink"
  end
end

class OneIndex
  def self.process_commands(commands)
    commands << "double blink"
  end
end

class TwoIndex
  def self.process_commands(commands)
    commands << "close your eyes"
  end
end

class ThreeIndex
  def self.process_commands(commands)
    commands << "jump"
  end
end

class FourIndex
  def self.process_commands(commands)
    commands.reverse!
  end
end

class SecretHandshake
  COMMANDS = [ZeroIndex, OneIndex, TwoIndex, ThreeIndex, FourIndex].freeze

  def initialize(number)
    @bin_digits = determine_binary_value(number).chars.reverse
  end

  def commands
    @bin_digits.each_with_object([]).with_index do |(digit, commands), index|
       COMMANDS[index].process_commands(commands) if digit == '1'
    end
  end

  @bin_digits.each_index do |index|
    COMMANDS[index].process_commands(commands)
  end

  private

  def determine_binary_value(number)
    if number.class == Integer
      number.to_s(2)
    elsif number.to_s =~ /[^01]/
      '0'
    else
      number
    end
  end
end

# p SecretHandshake.new(19).commands
# SecretHandshake.new('zebra').commands
# p SecretHandshake.new('101').commands
# p SecretHandshake.new(31).commands