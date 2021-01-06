# Write a program that computes Pascal's triangle up to a given number of rows.

# In Pascal's Triangle each number is computed by adding the numbers to the 
# right and left of the current position in the previous row.

#     1
#    1 1
#   1 2 1
#  1 3 3 1
# 1 4 6 4 1
# ... etc

# Input: an integer
# Output: An array of subarrays: (n subarrays in a sequence 1, 2... n-1, n in length)

# Data Structures:
#   Arrays

# Considerations:
#   Handling the edges where there is only one digit above?
#   Input of 0 Should return empty array?
#   When referenced index's value is nil, return 0 (subarray[-1] returns 0)


# Processing the problem:
#   Example: the value at index 1 is the sum of values at 0 and 1 in the above array
#            value at 2 is sum of values at 1 and 2 in above array


# Algorithm:
#   Start with a an array with a subarray of [[1]]
#   iterate n -  1 times
#   construct a new subarray based off of the values in the current last subarray
#   push the resulting subarray to the triangle array.

require 'code_timer'

class Triangle
  attr_reader :rows

  def initialize(size)
    @rows = []
    generate_triangle(size) unless size == 0
  end

  def generate_triangle(size)
    @size = size
    @rows << [1]
    2.upto(size) do |n|
      @rows << (0..(n - 1)).each_with_object([]) do |index, row|
                 row << @rows.last[index - 1, 2].sum
               end
    end
  end

  def to_s
    num_width = @rows.last.max.to_s.length
    @rows.map.with_index do |row, index|
      spaces = @size - (index + 1)
      row = row.map { |num| "%#{num_width}d" % num }
      ' ' * (num_width / 2 + 1) * spaces + row.join(' ')
    end.join("\n")
  end
end

# p Triangle.new(0).rows == []
CodeTimer.timer(5, 'Mine') do
  Triangle.new(2000).rows
end
# puts Triangle.new(25)

class Triangle
  attr_reader :rows

  def initialize(size)
    @size = size - 1
    @rows = calc_rows
  end

  private

  def calc_rows
    rows = [[1]]
    1.upto(@size - 1) do |i|
      seed = [0, *rows[-1], 0]
      new_row = []
      seed.each_cons(2) { |a, b| new_row << a + b }
      rows << new_row
    end
    rows
  end
end

CodeTimer.timer(5, 'Bob\'s') do
  Triangle.new(2000).rows
end