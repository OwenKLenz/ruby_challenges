# Write a program that will take a string of digits and give you all the 
# possible consecutive number series of length n in that string.

# For example, the string "01234" has the following 3-digit series:

# - 012
# - 123
# - 234
# And the following 4-digit series:

# - 0123
# - 1234
# And if you ask for a 6-digit series from a 5-digit string, you deserve 
# whatever you get.

# input: A string of digits
# output: An array of subarrays, each with the possible series of consecutive
# elements of n length

# Data Structures:
#   start with a string
#   End with a 2d array

# Notes:
#   Create a Series class with an attribute containing the string of digits
#   Should have a method #slices, which will return the array of subarrays
#   Need to stop once the last element of a subarray is the last character in 
#   the string

# Considerations:
#   Empty string should return empty array
#   Raise an ArgumentError when #slices receives an argument larger than the size
#   of the string

# Algo:
#   Create a Series class
#   new Series objects receive a string argument
#   Set the attribute equal to string split into an array of ints
  #slices(n) method:
  # raise new argerror if n argument is greater than size of array
  #   iterate across the array's indexes from index 0 to index -1 - n
  #   with map:
  #     each mapping should return the array from current index to current index + n

class Series
  def initialize(str_series)
    @numbers = str_to_integer_array(str_series)
    @length = @numbers.length
  end

  def slices(n)
    if n > @length
      raise ArgumentError.new("You can't cut a slice that's larger than the 
                               cake, you doofus!")
    elsif n <= 0
      raise ArgumentError.new("Slice size must be >= 1")
    end
    (0..(@length - n)).map { |ind| @numbers[ind...(ind + n)] }
  end

  private
  
  def str_to_integer_array(str)
    str.chars.map(&:to_i)
  end
end

begin
  p Series.new('1232').slices(2)
rescue ArgumentError
  puts "You were rescued from a fatal argument error by a knight in shining armour"
end