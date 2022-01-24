class Student
  attr_accessor :name
  def initialize(name, grade)
    @grade = grade
    @name = name
  end

  def better_grade_than?(other_student)
    grade > other_student.grade
  end

  protected
  def grade
    @grade
  end
end

joe = Student.new("Joe", 9)
bob = Student.new("Bob", 8)

puts "Well done!" if joe.better_grade_than?(bob)
