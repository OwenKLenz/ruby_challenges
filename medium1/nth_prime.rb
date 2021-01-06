# Input: Integer (the nth prime we want)
# Output: Integer, the value of the prime

# Data Structure:
#   Integers for input and Output
#   An integer to track the current prime


# Considerations:
#   Start at 2 (first prime)
#   Primes can only be odd (after 2) so ignore evens
#   Only checking divisibleness of numbers up to sqrt of current possible prime
#   Inputs less than 1 should return an ArgumentError

# Algorithm:
#   raise ArgumentError if the input is less than 1
#   return 2 if arg is 1

#   set prime counter to 2
#   set current value to 3

#   until prime counter is the argument value
#     add 2 to current value
#     2 upto sqrt of current value
#       break if current value is evenly divisble by upto value
#     increment prime counter

#   return current value

# class Prime
#   def self.nth(n)
#     raise ArgumentError if n < 1
#     return 2 if n == 1

#     prime_counter = 2
#     current_value = 3

#     loop do
#       return current_value if prime_counter == n
#       current_value += 2
#       prime_counter += 1 if prime?(current_value)
#     end
#   end

#   def self.prime?(current_value)
#     3.step(by: 2, to: Math.sqrt(current_value)) do |divisor|
#       return false if current_value % divisor == 0
#     end
#     true
#   end
# end

require 'code_timer'

class Prime
  @@primes = [2]

  def self.nth(num)
    raise ArgumentError unless num > 0
    generate_next_prime while @@primes.size < num
    @@primes[num - 1]
  end

  def self.generate_next_prime
    st = @@primes.size == 1 ? 3 : (@@primes.last + 2)
    st += 2 until is_prime?(st)
    @@primes << st
  end

  def self.is_prime?(num)
    3.step(to: Integer.sqrt(num), by: 2).none? { |arg| num % arg == 0 }
  end
end

CodeTimer.timer(1000, "His") { Prime.nth(100001)}

class Prime
  @@primes = [2]
  def self.nth(n)
    raise ArgumentError if n < 1
    return 2 if n == 1

    current_value = 3
    return @@primes[n - 1] if @@primes.size >= n
    loop do
      if prime?(current_value)
        @@primes << current_value if @@primes.last < current_value
      end
      return current_value if @@primes.size == n
      current_value += 2
    end
  end

  def self.prime?(current_value)
    stop_at = Math.sqrt(current_value)

    @@primes.each do |prime|
      return false if (current_value % prime) == 0
      break if prime > stop_at
    end
    true
  end
end

CodeTimer.timer(1000, "Mine") { Prime.nth(100001)}


p Prime.nth(1)
p Prime.nth(3)
p Prime.nth(4)
p Prime.nth(5)

