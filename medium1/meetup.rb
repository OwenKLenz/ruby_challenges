# Input: A month and year along with day of the week desired and the specific
#   iteration of that day in the month wanted (first, second, third, teenth,
#   fourth, last)

# Ouput: A Date object that matches those parameters

# Description:
#   1. Create a class Meetup, that specifies a month and year as attributes
#   2. Create an instance method that accepts a day of the week and an number of
#   the occurence of that day of the week wanted.

# Data Structure:
#   Array of Monday/Tuesday, etc
#   Hash of :first, :teenth, etc. keys with day of month values

# Algorithm:
# Select all the days from beginning to end of month that are the requested day
#   Select the day by converting the day_of_week to string, ? appended, back
#   to symbol and then symbol to proc'd as the block for select

require 'date'

class Meetup
  INSTANCE_OF_DAY_INDICES =
    { first: 0, second: 1, third: 2, fourth: 3, last: -1 }.freeze
  TEENTH_DAYS = (13..19).freeze

  def initialize(month, year)
    @month = month
    @year = year
    @month_and_year = Date.new(year, month)
  end

  def day(day_of_week, instance_of_day)
    @day_of_week_days = acquire_all_days(day_of_week)

    if instance_of_day == :teenth
      @day_of_week_days.find { |date| TEENTH_DAYS.cover?(date.day) }
    else
      @day_of_week_days[INSTANCE_OF_DAY_INDICES[instance_of_day]]
    end
  end

  private

  def acquire_all_days(day_of_week)
    day_of_week = (day_of_week.to_s + '?').to_sym
    @month_and_year
      .upto(@month_and_year.next_month - 1)
      .select(&day_of_week)
  end
end

class Meetup
  WEEK_START_INDEX = { first: 0,
                       second: 7,
                       third: 14,
                       fourth: 21,
                       last: -7,
                       teenth: 12 }

  def initialize(month, year)
    @month = (Date.new(year, month)...Date.new(year, month).next_month).to_a
  end

  def day(day_of_week, instance_of_day)
    @month[WEEK_INDEX_HASH[instance_of_day]..].find do |day| 
      day.send(day_of_week.to_s + '?')
    end
  end
end