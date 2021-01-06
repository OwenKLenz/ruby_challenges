# The Greek mathematician Nicomachus devised a classification scheme for 
# natural numbers, identifying each as belonging uniquely to the categories 
# of abundant, perfect, or deficient. A perfect number equals the sum of its
# positive divisors — the pairs of numbers whose product yields the target 
# number, excluding the number itself. This sum is known as the Aliquot sum.

# Perfect: Sum of factors = number
# Abundant: Sum of factors > number
# Deficient: Sum of factors < number


# Examples:

# 6 is a perfect number because its divisors are 1, 2, 3 and 6 = 1 + 2 + 3.
# 28 is a perfect number because 28 = 1 + 2 + 4 + 7 + 14.
# Prime numbers 7, 13, etc are deficient by the Nicomachus classification.
# Write a program that can tell if a number is perfect, abundant or deficient.

# Input: An integer
# Output: A string or raise a RuntimeError

# Data Structure:
#   integer, sum the factors as you go
#   Could use an array to push all of the factors to and then sum them

# Considerations:
#   Raise a RuntimeError if num <= 0
#   floats?
#   method is a class method

# Algorithm:
#   Iterate from 1 to square root of num
#   if num % iterator is 0, add iterator and num / iterator to sum
#   return sum


class PerfectNumber
  p self.self
  def self.classify(num)
    raise RuntimeError if num <= 0

    result = (2..Math.sqrt(num)).inject(1) do |sum, divisor|
      num % divisor == 0 ? sum + divisor + num / divisor : sum
    end

    case result
    when 1...num
      'deficient'
    when num
      'perfect'
    else
      'abundant'
    end
  end
end

p PerfectNumber.classify(10001)

def max_rotation(num)
  nums = num.to_s.chars
  nums.each_index do |index|
    nums.push(nums.delete_at(index))
  end
  nums.join.to_i
end

p max_rotation(735291) == 321579
p max_rotation(3) == 3
p max_rotation(53) == 35
p max_rotation(105) == 15
p max_rotation(8_703_529_146) == 7_321_609_845