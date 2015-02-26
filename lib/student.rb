class Student
  attr_reader :name, :id, :date_of_enrollment

  def initialize(properties)
    @name = properties[:name]
    @id = properties[:id]
    @date_of_enrollment = properties[:date_of_enrollment]
  end

  def self.all
    returned_courses = DB.exec("SELECT FROM students;")
    students = []
    returned_students.each do |student|
      name = student["name"]
      id = student["id"]
      date_of_enrollment = student["date_of_enrollment"]
    end
    students
  end
end
