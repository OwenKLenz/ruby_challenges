#!/usr/bin/env ruby

# Write a program that takes a word problem and returns the answer as an integer.

# e.g.

# What is 5 plus 13?

# The program should return 18.

# What is 7 minus 5 minus 1?

# The program should return 1.

# Remember, that these are verbal word problems, not treated as you normally 
# would treat a written problem. This means that you calculate as you move 
# forward each step. This means 3 + 2 * 3 = 15, not 9.

# Input: A text based math problem (striing)
# Output: Solution to said math problem

# Data Structures:
#   hash of operations- String keys: symbol values (method names)
#   Array of numbers and operations (one or two arrays?)

# Considerations:
#   If no number, no valid operation or numbers == operations+1 raise argument error
#   consecutive numbers or operations

# Algorithm:
#   select all words (split) that are either numbers or are keys in our operations hash

#   Argument error situation:
#     raise error If problem_array size is < 3 or size is even
#     If even index elements are numbers and odds are operations 

class WordProblem
  OPERATIONS_HASH = { "plus"       => :+,
                      "minus"      => :-,
                      "divided"    => :/,
                      "multiplied" => :*
                    }

  def initialize(question)
    @problem_array = sanitize(question)
    raise ArgumentError.new('Invalid question') unless valid_pattern?
  end

  # Solution using Kernel#eval
  # def answer
  #   eval(@problem_array.map { |el| number?(el) ? el : OPERATIONS_HASH[el] }.join(' '))
  # end

  # Solution without Kernel#eval
  def answer
    numbers, operators = @problem_array.partition.with_index { |_, i| i.even? }
    convert_operators(operators)
    accumulator = numbers[0].to_i

    numbers[1..].each_with_index do |number, index|
      accumulator = accumulator.send(operators[index], number.to_i)
    end
    accumulator
  end

  private
  
  def sanitize(question)
    question[/[^?]+/].split.select do |word| 
      number?(word) || operator?(word)
    end
  end

  def number?(string)
    string.to_i.to_s == string
  end

  def operator?(string)
    OPERATIONS_HASH.keys.include?(string)
  end

  def valid_pattern?
    return false if @problem_array.one? || !number?(@problem_array.last)

    numbers, operators = @problem_array.partition.with_index { |_, i| i.even? }
    
    operators.all?{ |op| operator?(op) } && numbers.all?{ |num| number?(num) }
  end

  def convert_operators(operators)
    operators.map! { |operator| OPERATIONS_HASH[operator] }
  end
end

p WordProblem.new('Who is the president of the United States?').problem_array

p WordProblem.new('What is 53 plus 2?').answer

p WordProblem.new('What is -1 plus -10?').answer

p WordProblem.new('What is 33 divided by -3?').answer


p WordProblem.new('plus 1 minus 2').answer
