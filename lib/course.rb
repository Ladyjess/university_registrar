class Course
  attr_reader :name, :id, :course_number

  def initialize(properties)
    @name = properties[:name]  #fetch properties of this class contained in a hash
    @id = properties[:id]
    @course_number = properties[:course_number]
  end

  def self.all
    returned_courses = DB.exec("SELECT * FROM courses;")
    courses = []
    returned_courses.each do |course|
      name = course["name"]
      id = course["id"].to_i
      course_number = course["course_number"]
      courses << Course.new({:name => name, :id => id, :course_number => course_number})
    end
   courses
  end

  def self.find(id_for_course)
    @id = id_for_course
    result = DB.exec("SELECT * FROM courses WHERE id = #{@id};")
    @name = result.first["name"]
    @course_number = result.first["course_number"]
    Course.new({:name => @name, :id => @id, :course_number => @course_number})
  end

  def save
    result = DB.exec("INSERT INTO courses (name, course_number) VALUES ('#{@name}', '#{@course_number}') RETURNING id;")
    @id = result.first["id"].to_i
  end

  def ==(another_course)
  self.name.==(another_course.name).&(self.id.==(another_course.id)).&(self.course_number.== (another_course.course_number))
  end

  def update(new_info)
    @name = new_info.fetch(:name, @name)  #second argument is for default value incase nothing is passed in. It wont raise errors
    @course_number = new_info.fetch(:course_number, @course_number)
    DB.exec("UPDATE courses SET name = '#{@name}', course_number = '#{@course_number}' WHERE id = #{@id};")
  end

  def update_student_ids(add_student_to_course)
    @name = add_student_to_course.fetch(:name, @name)
    @course_number = add_student_to_course[:course_number]
    DB.exec("UPDATE courses SET name = '#{@name}', course_number = '#{@course_number}' WHERE id = #{self.id};")
    add_student_to_course.fetch(:student_ids, []).each do |student_id|
      DB.exec("INSERT INTO courses_students (course_id, student_id) VALUES (#{self.id}, #{student_id});")
    end
  end

  def students
    courses_students = []
    results = DB.exec("SELECT student_id FROM courses_students WHERE student_id = #{self.id};")
    results.each do |result|
      student_id = result["student_id"].to_i
      student = DB.exec("SELECT * FROM students WHERE id = #{student_id};")
      name = student.first["name"]
      courses_students << Student.new({:name => name, :id => student_id, :date_of_enrollment => date_of_enrollment})
    end
    courses_students
  end

  def delete
    DB.exec("DELETE FROM courses_students WHERE course_id = #{self.id};")
    DB.exec("DELETE FROM courses WHERE id = #{self.id};")
  end
end
