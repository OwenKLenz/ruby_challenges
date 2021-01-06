# Write a program that, given a number, can find the sum of all the multiples of 
# particular numbers up to but not including that number.

# If we list all the natural numbers up to but not including 20 that are 
# multiples of either 3 or 5, we get 3, 5, 6, 9, 10, 12, 15, and 18. The sum of 
# these multiples is 78.

# Write a program that can find the sum of the multiples of a given set of 
# numbers. If no set of numbers is given, default to 3 and 5.

# Input: A list of numbers (variable number of arguments) to test for multipleness
# Output: A sum (integer) of all numbers that are multiples of the numbers 
#   passed in (default 3 and 5) up to a target number (but not including it)

# Data Structure:
#   Array to hold the "list" of arguments to a new object that we can iterate to 
#   find all the multiples
#   Range, or else start from each arg number and keep adding one more instance of
#   it until the top value is reached/exceeded

# Considerations:
#   Don't add the top number to the final sum if it is a multiple
#   What to do when we have a number that is a multiple of more than 1 argument
#     value? We only want ot add it once
#       WE COULD CREATE AN ARRAY OF MULTIPLES OF EACH OF THE ARGUMENTS, COMBINE 
#       THEM AT END, UNIQ THEM AND THEN INJECT :+

# Algo:
#   Create a hash with key of each arg and empty array for value
#   Array will store all of the multiples found.
#   For each key:
#     while the accumulator is < the max_num
#       add the key to an accumulator (inject?), starting from 0, and push that
#       to the value array at that key in the hash

#   add each array together, uniq and then inject addition

class SumOfMultiples
  def initialize(*args)
    @multiple_values = args.map { |val| [val, []] }.to_h
  end

  def self.to(max_num)
    self.new(3, 5).to(max_num)
  end

  def to(max_num)
    return 0 if max_num <= @multiple_values.keys.min

    @multiple_values.each_key do |multiple|
      accum = multiple
      while accum < max_num do
        @multiple_values[multiple] << accum
        accum += multiple
      end
    end
    @multiple_values.values.inject(:+).uniq.inject(:+)
  end
end

time1 = Time.now
10000.times do
  SumOfMultiples.new(1, 2, 3, 4, 5).to(25)
  SumOfMultiples.new(3, 10, 12).to(120)
  SumOfMultiples.to(1000)
end
puts "Total time: #{Time.now - time1}"


class SumOfMultiples
  def self.to(limit, multiples = [3, 5])
    (0...limit).select do |number|
      multiples.any? { |multiple| number % multiple == 0 }
    end.reduce(:+)
  end

  def initialize(*multiples)
    @multiples = multiples
  end

  def to(limit)
    self.class.to(limit, @multiples)
  end
end


time1 = Time.now
10000.times do
  SumOfMultiples.new(1, 2, 3, 4, 5).to(25)
  SumOfMultiples.new(3, 10, 12).to(120)
  SumOfMultiples.to(1000)
end

puts "Total time: #{Time.now - time1}"
