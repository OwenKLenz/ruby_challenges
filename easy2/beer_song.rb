# Write a program that can generate the lyrics of the 99 Bottles of Beer song. 
# See the test suite for the entire song.

# Input: A number of verses desired
# Output: A string containing that many verses (or range of verses)

# Data Structure:
#   Array of verses to be generated iteratively

# Considerations:
#   Handle:
#     Single verse requested
#     range of verses requested
#     all verses requested

# Algorithm:
#   Song lyric generation:
#     Start with array containing the no more bottles lyric
#     iterate from 1..99 interpolating the numbers into the generic lyric template
#       Append each lyric to lyrics array
    
#     Return lyrics based on argument joined with \n\n

class BeerSong
  def initialize
    @lyrics = ["No more bottles of beer on the wall, no more bottles of beer."\
    "\nGo to the store and buy some more, 99 bottles of beer on the wall.\n"] +
    ["1 bottle of beer on the wall, 1 bottle of beer.\n" \
    "Take it down and pass it around, no more bottles of beer on the wall.\n"]

    (2..99).each do |bottles|
      @lyrics << "#{bottles} bottle#{bottle_ending(bottles)} of beer on the wall, "\
      "#{bottles} bottle#{bottle_ending(bottles)} of beer.\n"\
      "Take one down and pass it around, #{bottles - 1} bottle"\
      "#{bottle_ending(bottles - 1)} of beer on the wall.\n"
    end
  end

  def verse(verse)
    verses(verse, verse)
  end

  def verses(start, finish)
    @lyrics[finish..start].reverse.join("\n")
  end

  def lyrics
    verses(99, 0)
  end

  private

  def bottle_ending(num_bottles)
    num_bottles == 1 ? '' : 's'
  end

  class VerseZero
    def verse(_)
      "No more bottles of beer on the wall, no more bottles of beer."\
      "\nGo to the store and buy some more, 99 bottles of beer on the wall.\n"
  end

  class VerseOne
    def verse(_)
      "1 bottle of beer on the wall, 1 bottle of beer.\n" \
      "Take it down and pass it around, no more bottles of beer on the wall.\n"
    end
  end

  class VerseTwo
    def verse(_)
      "2 bottles of beer on the wall, 2 bottles of beer.\n" \
      "Take it down and pass it around, 1 bottle of beer on the wall.\n"
    end
  end

  class VerseDefault
    def verse(n)
      "#{n} bottles of beer on the wall, #{n} bottles of beer.\n"\
      "Take one down and pass it around, #{n - 1} bottles of beer on the wall.\n"
    end
  end

  the_hash = Hash.new(VerseDefault).merge({ 0 => VerseZero, 1 => VerseOne, 2 => VerseTwo })
  def verse(n)
    the_hash[n].new.verse
  end

  def verses(start, stop)
    start..stop.map do |n|
      verse(n)
    end
  end

  def lyrics
    verses(99, 0)
  end
  BeerSong.new.verse(n)
end
