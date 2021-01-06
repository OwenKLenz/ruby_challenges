# Input:
#   A student's name and their numeric grade

# Output:
#   A hash of grades followed by students' names

# Data Stucture:
#   A hash of grade keys and an array of the students in that grade.

# Algorithm:
#   In the school class initialize with a hash whose value defaults to []
#   Then adding a student is simply << a student to the array associated with the key of
#   that student's grade.

class School
  def initialize
    @grades = Hash.new([])
  end

  def add(student, grade)
    @grades[grade] += [student]
  end

  def grade(number)
    @grades[number]
  end

  def to_h
    @grades.map { |grade, students| [grade, students.sort] }.sort.to_h
  end
end

class UserData
  attr_reader :users_info
  def initialize(users)
    @users = users
    @users_info = Hash.new do |hash, user|
                   hash[user] = [rand(1000)]
                 end
  end

  def set_user_data
    @users.each { |user| @user_data[user] << "Registered"}
  end
end
