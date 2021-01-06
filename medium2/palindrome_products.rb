require 'code_timer'

class Palindromes
  def initialize(max_factor: 1, min_factor: 1)
    @max_factor = max_factor
    @min_factor = min_factor
    @palindromes_hash = Hash.new([])
  end

  def generate  
    counter1 = @min_factor

    until counter1 > @max_factor do
      counter2 = counter1

      until counter2 > @max_factor
        product = counter2 * counter1
        @palindromes_hash[product] += [[counter1, counter2]] if palindrome?(product.to_s)
        counter2 += 1
      end
      counter1 += 1
    end
  end

  def palindrome?(product_string)
    product_string == product_string.reverse
  end

  def largest
    largest_palindrome = @palindromes_hash.keys.sort.last
    Palindrome.new(largest_palindrome, @palindromes_hash[largest_palindrome])
  end

  def smallest
    smallest_palindrome = @palindromes_hash.keys.sort.first
    Palindrome.new(smallest_palindrome, @palindromes_hash[smallest_palindrome])
  end
end

class Palindrome
  attr_reader :value, :factors

  def initialize(palindrome_product, factors)
    @value = palindrome_product
    @factors = factors
  end
end


CodeTimer.timer(10, "old") do
  pal = Palindromes.new(max_factor: 999, min_factor: 100)
  pal.generate
  pal.smallest
  pal.largest
  pal.smallest.factors
end

# class Palindromes
#   attr_reader :smallest, :largest

#   def initialize(max_factor: 1, min_factor: 1)
#     @max_factor = max_factor
#     @min_factor = min_factor
#     @palindromes_hash = Hash.new([])
#   end

#   def generate
#     @smallest = Palindrome.new(*generate_smallest)
#     @largest = Palindrome.new(*generate_largest)
#   end

#   def generate_largest
#     (@max_factor ** 2).downto(1) do |n|
#       if n.to_s == n.to_s.reverse
#         @max_factor.downto(1) do |factor|
#           break if n / factor > factor
#           return [n, [[n / factor, factor]]] if n % factor == 0
#         end
#       end
#     end
#   end

#   def generate_smallest
#     (@min_factor ** 2).upto(@max_factor ** 2) do |n|
#       if n.to_s == n.to_s.reverse
#         @min_factor.upto(@max_factor) do |factor|
#           break if n / factor < factor
#           return [n, [[n / factor, factor]]] if n % factor == 0
#         end
#       end
#     end
#   end
# end

# class Palindrome
#   attr_reader :value, :factors

#   def initialize(palindrome_product, factors)
#     @value = palindrome_product
#     @factors = factors
#   end
# end

# CodeTimer.timer(10, "new") do
#   pal = Palindromes.new(max_factor: 999, min_factor: 100)
#   pal.generate
#   pal.smallest
#   pal.largest
#   pal.smallest.factors
# end