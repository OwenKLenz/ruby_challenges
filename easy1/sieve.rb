# intput: an integer (the value below (and including which all of the primes 
# must be found)

# output: an array of all of the primes found

# Notes:
#   Take an integer argument
#   find all the primes from 2 upto and including that argument
#   Use the sieve:
#     starting with 2, mark 2 as a prime and then cross off all multiples of 2
#     then mark 3 as a prime, etc.

# Algo:
#   Start with a range from 2..num converted to an array
#   reassign array variable to the return value of select
#     starting with 2 select all numbers that are not divisible by 2
#     repeat until the selected array is equal to the array that called select

# When to stop calling select:
# First set prime_index to 0
# loop
#   create a starting_nums array copy of @nums with clone

class Sieve
  def initialize(n)
    @current_nums = (2..n).to_a
  end

  def primes
    0.upto(@current_nums.size) do |index|
      current_prime = @current_nums[index]
      @current_nums.select! do |num|
        num == current_prime || !(num % current_prime == 0)
      end
      return @current_nums if current_prime == @current_nums.last
    end
  end
end

sieve = Sieve.new(11)
p sieve.primes

sieve = Sieve.new(2)
p sieve.primes

sieve = Sieve.new(1000)
p sieve.primes