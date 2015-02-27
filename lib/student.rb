class Student
  attr_reader :name, :id, :date_of_enrollment

  def initialize(properties)   #fetch properties in the hash
    @name = properties[:name]
    @id = properties[:id]
    @date_of_enrollment = properties[:date_of_enrollment]
  end

  def self.all
    returned_students = DB.exec("SELECT * FROM students;")  #fetch from database
    students = []
    returned_students.each do |student|
      name = student["name"]
      id = student["id"].to_i
      date_of_enrollment = student["date_of_enrollment"]
    end
    students
  end

  def self.find(id_for_student)
    @id = id_for_student
    result = DB.exec("SELECT * FROM students WHERE id = #{@id};")
    @name = result.first["name"]
    @date_of_enrollment = result.first["date_of_enrollment"]
    Student.new({:name => @name, :id => @id, :date_of_enrollment => @date_of_enrollment})
  end

  def save
    result = DB.exec("INSERT INTO students (name, date_of_enrollment) VALUES ('#{@name}', '#{@date_of_enrollment}') RETURNING id;")
    @id = result.first["id"].to_i
  end

  def ==(another_student)
  self.name.==(another_student.name).&(self.id.==(another_student.id)).&(self.date_of_enrollment.== (another_student.date_of_enrollment))
  end

  def update(new_info)
    @name = new_info.fetch(:name, @name)
    @date_of_enrollment = new_info.fetch(:date_of_enrollment, @date_of_enrollment)
    DB.exec("UPDATE students SET name = '#{@name}', date_of_enrollment = '#{@date_of_enrollment}' WHERE id = #{@id};")
  end

  def update_course_ids(add_course_to_student)
    @name = add_course_to_student.fetch(:name, @name)
    @date_of_enrollment = add_course_to_student.fetch(:date_of_enrollment, @date_of_enrollment)
    DB.exec("UPDATE students SET name = '#{@name}', date_of_enrollment = '#{@date_of_enrollment}' WHERE id = #{self.id};")
    add_course_to_student.fetch(:course_ids, []).each do |course_id|
      DB.exec("INSERT INTO courses_students (student_id, course_id) VALUES (#{self.id}, #{course_id});")
    end
  end

  def courses
    awesome_courses = []
    results = DB.exec("SELECT course_id FROM courses_students WHERE course_id = #{self.id};")
    results.each do |result|
      course_id = result["course_id"].to_i
      course = DB.exec("SELECT * FROM courses WHERE id = #{course_id};")
      name = course.first["name"]
      awesome_courses << Course.new({:name => name, :id => course_id, :course_number => course_number})
    end
    awesome_courses
  end

  def delete
    DB.exec("DELETE FROM courses_students WHERE student_id = #{self.id};")
    DB.exec("DELETE FROM students WHERE id = #{self.id};")
  end

end
