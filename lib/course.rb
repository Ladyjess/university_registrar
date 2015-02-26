class Course
  attr_reader :name, :id, :course_number

  def initialize(properties)
    @name = properties[:name]  #properties the class (.fetch) "name"
    @id = properties[:id]
    @course_numer = properties[:course_number]
  end

  def self.all
    returned_courses = DB.exec("SELECT * FROM courses;")
    courses = []
    returned_courses.each do |course|
      name = course["name"]
      id = course["id"].to_i
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

  def update(new_name)
    @name = new_name.fetch(:name, @name)  #second argument is for default value incase nothing is passed in. It wont raise errors
    DB.exec("UPDATE courses SET name = '#{@name}', course_number = '#{@course_number}' WHERE id = #{@id};")
  end


  def update_course_id(properties)
    @name = properties[:name, @name]
    @course_number = properties[:course_number]
    DB.exec("UPDATE courses SET name = '#{@name}' WHERE id = #{self.id};")
    DB.exec("UPDATE courses SET course_number = '#{@course_number}' WHERE id = #{@id};")
    properties.fetch(:student_ids, []).each do |student_id|
      DB.exec("INSERT INTO courses_students (student_id, course_id) VALUES (#{self.id}, #{student_id});")
    end
  end
end





#
# define_method(:movies) do
#   actor_movies = []
#   results = DB.exec("SELECT movie_id FROM actors_movies WHERE actor_id = #{self.id()};")
#   results.each() do |result|
#     movie_id = result.fetch("movie_id").to_i()
#     movie = DB.exec("SELECT * FROM movies WHERE id = #{movie_id};")
#     name = movie.first().fetch("name")
#     actor_movies.push(Movie.new({:name => name, :id => movie_id}))
#   end
#   actor_movies
# end
#
# define_method(:delete) do
#   DB.exec("DELETE FROM actors_movies WHERE actor_id = #{self.id()};")
#   DB.exec("DELETE FROM actors WHERE id = #{self.id()};")
# end
