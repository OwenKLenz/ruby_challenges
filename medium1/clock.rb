# Input: Hour and optional minutes as integers
# Output: A clock objectwith the indicated time

# Data Structures:
# Integers to store the hour and minutes

# Considerations:
#   Clocks are initialized with Clock::at
#   Need Clock#to_s and Clock#+/- and Clock#== methods
  # - and + methods need to return a clock object

class Clock
  attr_accessor :hour, :minute

  def self.at(hours, minutes=0)
    new_clock = Clock.new
    new_clock.minute = minutes
    new_clock.hour = hours
    new_clock
  end

  def +(minutes)
    self.minute += minutes
    self.hour += minute / 60
    self.hour %= 24
    self.minute %= 60
    self
  end

  def -(minutes)
    self + -minutes
  end

  def ==(other_clock)
    hour == other_clock.hour && minute == other_clock.minute
  end

  def to_s
    "%02i:%02i" % [hour, minute]
  end
end

p (Clock.at(9, 1) - 2).to_s == "08:59"
p (Clock.at(9, 59) + 2).to_s == "10:01"
p (Clock.at(9, 59) + 62).to_s == "11:01"
p (Clock.at(9, 59) - 62).to_s == "08:57"
p (Clock.at(23, 59) + 2).to_s == "00:01"
p (Clock.at(23, 59) + 62).to_s == "01:01"
p (Clock.at(0, 1) - 2).to_s == "23:59"
# (Clock.at(0, 1) - 62).to_s == "22:59"
# # I was a little surprised when this worked as there are some funky properties of
# the modulo and integer division operators at work here.
# Integer division in Ruby "always rounds towards negative infinity". So as
# expected, `10 / 11 == 0` in Ruby. So what about `-10 / 11`? It turns out it's
# not zero, but -1 instead because again,  we are rounding down towards negative
# infinity (note this isn't the case in all languages, C for instance, which 
# rounds towards 0). The upshot of this is that `self.hour += minute / 60` will correctly
# decrement the `hour` if `minute` ends up being a negative value (ie: we 
# subtract 10 minutes from "00:05").

# The other funky situation is when `minute` again winds up being negative and we 
# call `self.minute %= 60`. If `minute` was `-10`, `-10 % 60` returns 50. So far
# I haven't been able to wrap my head around why, but for some reason Ruby thinks
# that `60` goes into `-10` -1 times with a remainder of 50 (try `-10.divmod(60)`).

# For a positive number divided by a positive number, say 10 / 100, we would say
# that 100 goes into to 10 0 times with a remainder of 10. When the divisor is negative
# its true that -100 goes into 10 zero times, but in reality it goes in -0.1 times,
# which because of the way integer division works in Ruby, gets rounded down to 
# -1 times. Since -100


# my_clock = Clock.at(9, 59) + 2
# puts my_clock

# # my_clock + 70